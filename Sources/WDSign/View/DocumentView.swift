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
            if let backgroundWatermark = viewModel.getDocumentLayoutInfo().watermark {
                Image(backgroundWatermark)
                    .resizable()
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .aspectRatio(contentMode: .fit)
                    .opacity(0.12)
            }
            
            if let logo = viewModel.getDocumentLayoutInfo().logo {
                Image(logo)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 250, height: 200, alignment: .center)
                    .opacity(0.62)
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topTrailing)
            }
            
            VStack(spacing: 0) {
                Text(viewModel.getDocumentLayoutInfo().documentText)
                    .padding(.top, 100)
                    .frame(maxWidth: 620, maxHeight: .infinity, alignment: .topLeading)
                
                ForEach(0..<viewModel.getNumberOfSignatureFields(), id: \.self) { index in
                    SignFieldView(showModal: $showModal, signatureImage: $signatureImages, subscriber: viewModel.getSubscriber(at: index))
                        .padding(.bottom, 110)
                }
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(#colorLiteral(red: 0.9333333333, green: 0.9529411765, blue: 0.9607843137, alpha: 1)))
    }
    
    @ObservedObject var viewModel: WDSignViewModel
    @Binding public var showModal: Bool
    @Binding public var canvas: PKCanvasView
    @Binding public var signatureImages: Image?
    @Binding public var selectedCanvasIndex: Int
}
