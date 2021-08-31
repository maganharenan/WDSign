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
                    .frame(width: 250, height: 200, alignment: .top)
                    .opacity(0.62)
                    .padding(16)
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topTrailing)
            }
            
            VStack(spacing: 0) {
                Text(viewModel.getDocumentLayoutInfo().documentText.replacingOccurrences(of: "{PRODUCT_LIST}", with: viewModel.buildProductsList()))
                    .padding(.top, 100)
                    .frame(maxWidth: 620, maxHeight: .infinity, alignment: .topLeading)
                
                if viewModel.getDocumentLayoutInfo().isAware == 1 {
                    Button {
                        aware.toggle()
                    } label: {
                        HStack {
                            Image(systemName: aware ? "checkmark.circle.fill" : "checkmark.circle")
                                .imageScale(.large)
                                .frame(width: 44, height: 44)
                                .foregroundColor(AppColorsDAO.instance.system_color_7.getColorFromHex())
                            
                            Text(Constants.SystemResources.iAmAware.translateResource())
                                .foregroundColor(.black)
                        }
                    }
                    .frame(maxWidth: 620, maxHeight: 50, alignment: .leading)
                    .padding(.bottom, 110)
                } else {
                    ForEach(0..<viewModel.getNumberOfSignatureFields(), id: \.self) { index in
                        SignFieldView(showModal: $showModal, signatureImage: $signatureImages, subscriber: viewModel.getSubscriber(at: index))
                            .padding(.bottom, 110)
                    }
                }
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)))
    }
    
    @ObservedObject var viewModel: WDSignViewModel
    @Binding public var showModal: Bool
    @Binding public var canvas: PKCanvasView
    @Binding public var signatureImages: Image?
    @Binding public var selectedCanvasIndex: Int
    @Binding public var aware: Bool
}
