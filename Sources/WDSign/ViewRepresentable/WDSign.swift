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
        ZStack {
            VStack(spacing: 0) {
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
                    
                    Text(documentLayoutInfo?.title ?? "")
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
                }
                .frame(maxWidth: .infinity, maxHeight: 50)
                .background(Color.white)
                
                documentView
                
            }
            .navigationBarHidden(true)

            if showModal {
                SignatureBoxView(canvas: $canvas, showModal: $showModal, signatureImage: $signatureImages)
            }
        }
    }
    
    public var documentView: some View {
        DocumentView(documentLayoutInfo: documentLayoutInfo, placeholders: handlePlaceholders(), showModal: $showModal, canvas: $canvas, signatureImages: $signatureImages, selectedCanvasIndex: $selectedCanvasIndex)
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
    
    private func handlePlaceholders() -> Array<String> {
        var placeholders = Array<String>()
        
        guard let placeholder1 = documentLayoutInfo.placeholderSubscriber1 else { return [] }
        placeholders.append(placeholder1)
        
        guard let placeholder2 = documentLayoutInfo.placeholderSubscriber2 else { return placeholders }
        placeholders.append(placeholder2)
        
        guard let placeholder3 = documentLayoutInfo.placeholderSubscriber3 else { return placeholders }
        placeholders.append(placeholder3)
        
        return placeholders
    }
    
    private func saveDocument() {
        withAnimation {
            buttonsOpactity = 0
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            self
                .snapshot()
                .saveImageOnDocuments() { segue in
                    if segue {
                        withAnimation {
                            buttonsOpactity = 1
                        }
                    }
                }
        }
    }
}

struct WDSign_Previews: PreviewProvider {
    static var previews: some View {
        WDSign(documentID: 1)
    }
}