//
//  WDSign.swift
//
//
//  Created by Renan Maganha on 21/06/21.
//

import SwiftUI
import PencilKit

public struct WDSign: View {
    public var body: some View {
        ZStack(alignment: .center) {
            VStack(spacing: 0) {
                ZStack {
                    HStack {
                        Button(action: {
                            self.presentationMode.wrappedValue.dismiss()
                        }, label: {
                            Text(Constants.SystemResources.Cancel.translateResource())
                                .font(.body)
                                .foregroundColor(AppColorsDAO.instance.system_color_14.getColorFromHex())
                                .frame(width: 100, height: 44)
                                .opacity(buttonsOpactity)
                        })
                        
                        Text(viewModel.getDocumentLayoutInfo().title)
                            .font(.title2)
                            .foregroundColor(AppColorsDAO.instance.system_color_7.getColorFromHex())
                            .frame(maxWidth: .infinity)
                            .opacity(buttonsOpactity)
                        
                        Button(action: {
                            saveDocument()
                        }, label: {
                            Text(Constants.SystemResources.Save.translateResource())
                                .font(.headline)
                                .foregroundColor(AppColorsDAO.instance.system_color_15.getColorFromHex())
                                .frame(width: 100, height: 44)
                                .opacity(buttonsOpactity)
                        })
                        .alert(isPresented: $showAlert) {
                            Alert(
                                title: Text(alertTitle),
                                message: Text(alertBody),
                                dismissButton: .default(Text("OK"))
                            )
                        }
                    }
                    .frame(maxWidth: .infinity, maxHeight: 50)
                    .background(Color.white)
                    
                    Rectangle()
                        .frame(maxWidth: .infinity, maxHeight: 0.75)
                        .foregroundColor(AppColorsDAO.instance.system_color_3.getColorFromHex())
                        .frame(maxWidth: .infinity, maxHeight: 50, alignment: .bottom)
                }
                
                documentView
                
            }
            .navigationBarHidden(true)

            SignatureBoxView(canvas: $canvas, showModal: $showModal.onChange(changeCurrentCanvas(_:)), signatureImage: $signatureImages[selectedCanvasIndex])
        }
    }
    
    public var documentView: some View {
        ScrollView {
            ZStack {
                Color.purple
            DocumentView(viewModel: viewModel, showModal: $showModal.onChange(changeCurrentCanvas(_:)), signatureImages: $signatureImages, selectedCanvasIndex: $selectedCanvasIndex, aware: $aware)
                .overlay(
                    GeometryReader { proxy in
                        Color.clear.onAppear {
                            documentSize = CGSize(width: proxy.size.width, height: proxy.size.height)
                        }
                    }
                )
            }
        }
    }

    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @ObservedObject var viewModel: WDSignViewModel
    
    @State public var showModal = false
    @State var canvas = PKCanvasView()
    @State var drawings: Array<PKDrawing> = [PKDrawing(), PKDrawing(), PKDrawing()]
    @State public var signatureImages: Array<Image?> = [nil, nil, nil]
    @State public var selectedCanvasIndex: Int = 0
    @State var buttonsOpactity: Double = 1
    @State var aware: Bool = false
    @State var showAlert: Bool = false
    @State var alertTitle = ""
    @State var alertBody = ""
    @State var documentSize: CGSize = CGSize(width: 0.0, height: 0.0)
    @Binding var viewController: UIViewController
    
    public init(documentID: Int, customerFormRecordID: String?, productsList: [String:Array<(String, String, String)>], contactFormRecordID: String?, viewController: Binding<UIViewController>) {
        self.viewModel = WDSignViewModel(documentID: documentID, customerFormRecordID: customerFormRecordID, productsList: productsList, contactFormRecordID: contactFormRecordID)
        self._viewController = viewController
    }
    
    private func errorAlertWithCustom(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let dismissAction = UIAlertAction(title: "Ok", style: .default)
        dismissAction.setValue(UIColor(hexString: "3C697F"), forKey: "titleTextColor")
        
        alert.addAction(dismissAction)
        
        DispatchQueue.main.async {
            viewController.present(alert, animated: true)
        }
    }

    private func changeCurrentCanvas(_ bool: Bool) {
        if bool == true {
            canvas.drawing = drawings[selectedCanvasIndex]
        } else {
            drawings[selectedCanvasIndex] = canvas.drawing
        }
    }
    
    private func checkIfAllCanvasHasDrawings() -> Bool {
        var segue = true
        
        for index in 0..<viewModel.getNumberOfSignatureFields() {
            if drawings[index].strokes.count <= 0 {
                segue = false
            }
        }
        
        return segue
    }
 
    private func saveDocument() {
        if viewModel.getDocumentLayoutInfo().isAware == 1 {
            alertTitle = Constants.SystemResources.alertTitlePendingAgreement.translateResource()
            alertBody = Constants.SystemResources.alertBodyPendingAgreement.translateResource()
            guard aware == true else {
                //errorAlertWithCustom(title: alertTitle, message: alertBody)
                showAlert.toggle()
                return
            }
        } else {
            alertTitle = Constants.SystemResources.alertTitlePendingSign.translateResource()
            alertBody = Constants.SystemResources.alertBodyPendingSign.translateResource()
            guard checkIfAllCanvasHasDrawings() else {
                //errorAlertWithCustom(title: alertTitle, message: alertBody)
                showAlert.toggle()
                return
            }
        }
        
//        withAnimation {
//            buttonsOpactity = 0
//        }

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            let signLogID = UUID().uuidString

            print("document Size: \(documentSize)")

            documentView
                .snapshot(with: documentSize)
                .saveImageOnDocuments(imageName: signLogID) { segue in
                    if segue {
                        withAnimation {
                            buttonsOpactity = 1
                        }
                    }
                }
            viewModel.handleSignaturePersistence(id: signLogID) { success in
                if success {
                    viewModel.sendNotificationToWDSpace()
                    self.presentationMode.wrappedValue.dismiss()
                }
            }
        }
    }
}

struct WDSign_Previews: PreviewProvider {
    static var previews: some View {
        WDSign(documentID: 1, customerFormRecordID: nil, productsList: [:], contactFormRecordID: nil, viewController: .constant(UIViewController()))
    }
}
