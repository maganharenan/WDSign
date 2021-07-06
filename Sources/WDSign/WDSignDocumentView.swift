//
//  SwiftUIView.swift
//  
//
//  Created by Renan Maganha on 21/06/21.
//

import SwiftUI
import PencilKit

public struct WDSign: View {
    public var body: some View {
        ZStack {
            VStack(spacing: 0) {
                /// Navigation  bar
                HStack {
                    Button(action: {
                        self.presentationMode.wrappedValue.dismiss()
                    }, label: {
                        Text("Cancel")
                            .font(.body)
                            .foregroundColor(Color(#colorLiteral(red: 0.9176470588, green: 0.462745098, blue: 0.4078431373, alpha: 1)))
                            .frame(width: 100, height: 44)
                            .opacity(buttonsOpactity)
                    })
                    
                    Text(documentLayoutInfo?.title ?? "")
                        .font(.title2)
                        .foregroundColor(Color(#colorLiteral(red: 0.2352941176, green: 0.4117647059, blue: 0.4980392157, alpha: 1)))
                        .frame(maxWidth: .infinity)
                    
                    Button(action: {
                        buttonsOpactity = 0
                        self
                            .snapshot()
                            .saveImageOnDocuments()
                        buttonsOpactity = 1
                    }, label: {
                        Text("Save")
                            .font(.headline)
                            .foregroundColor(Color(#colorLiteral(red: 0.4549019608, green: 0.7333333333, blue: 0.7098039216, alpha: 1)))
                            .frame(width: 100, height: 44)
                            .opacity(buttonsOpactity)
                    })
                }
                .frame(maxWidth: .infinity, maxHeight: 50)
                
                documentView
                
            }
            .navigationBarHidden(true)

            if showModal {
                SignatureBoxView(canvas: $canvas, showModal: $showModal, signatureImage: $signatureImages)
            }
        }
    }
    
    public var documentView: some View {
        WDSignDocumentView(documentLayoutInfo: documentLayoutInfo, showModal: $showModal, canvas: $canvas, signatureImages: $signatureImages, selectedCanvasIndex: $selectedCanvasIndex)
    }
    
    var documentLayoutInfo: SignDocumentLayoutInfo!
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @State public var showModal = false
    @State public var canvas = PKCanvasView()
    @State public var signatureImages: Image?
    @State public var selectedCanvasIndex: Int = 0
    @State var buttonsOpactity: Double = 1
    
    public init(documentID: Int) {
        self.documentLayoutInfo = WDSignDAO.instance.fetchDocumentInformations(documentID: documentID)
    }
}

struct WDSign_Previews: PreviewProvider {
    static var previews: some View {
        WDSign(documentID: 1)
    }
}

public struct WDSignDocumentView: View {
    public var body: some View {
        ZStack {
            if let backgroundWatermark = documentLayoutInfo?.watermark {
                Image(backgroundWatermark)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .aspectRatio(contentMode: .fit)
            }
            
            VStack(spacing: 0) {
                Text(documentLayoutInfo.documentText)
                    .padding(.top, 100)
                    .frame(maxWidth: 620, maxHeight: .infinity, alignment: .topLeading)
                
                SignFieldView(showModal: $showModal, signatureImage: $signatureImages)
                    .padding(.bottom, 110)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(#colorLiteral(red: 0.9333333333, green: 0.9529411765, blue: 0.9607843137, alpha: 1)))
    }
    
    var documentLayoutInfo: SignDocumentLayoutInfo!
    @Binding public var showModal: Bool
    @Binding public var canvas: PKCanvasView
    @Binding public var signatureImages: Image?
    @Binding public var selectedCanvasIndex: Int
}



extension View {
    func snapshot() -> UIImage {
        let controller = UIHostingController(rootView: self)
        let view = controller.view

        let targetSize = CGSize(width: 1024, height: 768)
        view?.bounds = CGRect(origin: .zero, size: targetSize)
        view?.backgroundColor = .clear

        let renderer = UIGraphicsImageRenderer(size: targetSize)

        return renderer.image { _ in
            view?.drawHierarchy(in: controller.view.bounds, afterScreenUpdates: true)
        }
    }
}

extension UIImage {
    func saveImageOnDocuments() {
        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        // choose a name for your image
        let fileName = "image.jpg"
        // create the destination file url to save your image
        let fileURL = documentsDirectory.appendingPathComponent(fileName)
        // get your UIImage jpeg data representation and check if the destination file url already exists
        if let data = self.pngData(),
          !FileManager.default.fileExists(atPath: fileURL.path) {
            do {
                // writes the image data to disk
                try data.write(to: fileURL)
                print("file saved")
            } catch {
                print("error saving file:", error)
            }
        }
    }
}
