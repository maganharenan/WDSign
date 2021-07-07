//
//  DocumentView.swift
//  
//
//  Created by Renan Maganha on 21/06/21.
//

import SwiftUI
import PencilKit

public struct DocumentView: View {
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
                
                ForEach(0..<getNumberOfSignatureFields(), id: \.self) { index in
                    SignFieldView(showModal: $showModal, signatureImage: $signatureImages, placeholderDataFor: placeholders[index])
                        .padding(.bottom, 110)
                }
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(#colorLiteral(red: 0.9333333333, green: 0.9529411765, blue: 0.9607843137, alpha: 1)))
    }
    
    var documentLayoutInfo: SignDocumentLayoutInfo!
    var placeholders: Array<String>
    @Binding public var showModal: Bool
    @Binding public var canvas: PKCanvasView
    @Binding public var signatureImages: Image?
    @Binding public var selectedCanvasIndex: Int
    
    private func getNumberOfSignatureFields() -> Int {
        Constants.SubscriberType.init(rawValue: documentLayoutInfo.subscriberTypeDescription)?.numberOfSignatureFields ?? 1
    }
}
