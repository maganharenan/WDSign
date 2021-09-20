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
                    Rectangle()
                        .frame(maxWidth: .infinity, maxHeight: 0.75)
                        .foregroundColor(AppColorsDAO.instance.system_color_3.getColorFromHex())
                        .frame(maxWidth: .infinity, maxHeight: 50, alignment: .bottom)
                    
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
                }
                
                documentView
                
            }
            .navigationBarHidden(true)

            SignatureBoxView(canvas: $canvas[selectedCanvasIndex], showModal: $showModal, signatureImage: $signatureImages[selectedCanvasIndex])
        }
    }
    
    public var documentView: some View {
        DocumentView(viewModel: viewModel, showModal: $showModal, canvas: $canvas, signatureImages: $signatureImages, selectedCanvasIndex: $selectedCanvasIndex, aware: $aware)
    }

    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @ObservedObject var viewModel: WDSignViewModel
    
    @State public var showModal = false
    @State public var canvas: Array<PKCanvasView> = [PKCanvasView(), PKCanvasView(), PKCanvasView()]
    @State public var signatureImages: Array<Image?> = [nil, nil, nil]
    @State public var selectedCanvasIndex: Int = 0
    @State var buttonsOpactity: Double = 1
    @State var aware: Bool = false
    @State var showAlert: Bool = false
    @State var alertTitle = ""
    @State var alertBody = ""
    
    public init(documentID: Int, customerFormRecordID: String?, productsList: Array<String>, contactFormRecordID: String?) {
        self.viewModel = WDSignViewModel(documentID: documentID, customerFormRecordID: customerFormRecordID, productsList: productsList, contactFormRecordID: contactFormRecordID)
    }
    
    private func checkIfAllCanvasHasDrawings() -> Bool {
        var error = false
        
        canvas.forEach {phCanvas in
            if phCanvas.drawing.strokes.count <= 0 {
                error = true
            }
        }
        
        return error
    }
 
    private func saveDocument() {
        if viewModel.getDocumentLayoutInfo().isAware == 1 {
            alertTitle = Constants.SystemResources.alertTitlePendingAgreement.translateResource()
            alertBody = Constants.SystemResources.alertBodyPendingAgreement.translateResource()
            guard aware == true else {
                showAlert.toggle()
                return
            }
        } else {
            alertTitle = Constants.SystemResources.alertTitlePendingSign.translateResource()
            alertBody = Constants.SystemResources.alertBodyPendingSign.translateResource()
            guard checkIfAllCanvasHasDrawings() else {
                showAlert.toggle()
                return
            }
        }
        
        withAnimation {
            buttonsOpactity = 0
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            let signLogID = UUID().uuidString
            self
                .snapshot()
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
        WDSign(documentID: 1, customerFormRecordID: nil, productsList: [], contactFormRecordID: nil)
    }
}
