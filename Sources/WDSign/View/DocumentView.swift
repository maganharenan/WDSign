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
                VStack(spacing: 0) {
                    Text(viewModel.getDocumentLayoutInfo().documentText.replacingOccurrences(of: "{PRODUCT_LIST}", with: viewModel.buildProductsList()))
                        .padding(.top, 100)
                        .frame(maxWidth: 620, alignment: .topLeading)
                    
                    Text(viewModel.getFormatedDateToDocument())
                        .padding(.top, 20)
                        .font(.system(size: 15, weight: .semibold))
                        .frame(maxWidth: 620, alignment: .topLeading)
                }
                .frame(maxWidth: 620, maxHeight: .infinity, alignment: .topLeading)
                
                if viewModel.getDocumentLayoutInfo().isAware == 1 {
                    Button {
                        aware.toggle()
                    } label: {
                        HStack {
                            Image(systemName: aware ? "checkmark.circle.fill" : "checkmark.circle")
                                .imageScale(.large)
                                .frame(width: 44, height: 44)
                                .foregroundColor(aware ? AppColorsDAO.instance.system_color_15.getColorFromHex() : AppColorsDAO.instance.system_color_16.getColorFromHex())
                            
                            Text(Constants.SystemResources.iAmAware.translateResource())
                                .foregroundColor(.black)
                        }
                    }
                    .frame(maxWidth: 620, maxHeight: 50, alignment: .leading)
                    .padding(.bottom, 110)
                } else {
                    HStack(spacing: 0) {
                        ForEach(0..<viewModel.getNumberOfSignatureFields(), id: \.self) { index in
                            SignFieldView(selectedCanvasIndex: $selectedCanvasIndex, showModal: $showModal, signatureImage: $signatureImages[index], subscriber: viewModel.getSubscriber(at: index), currentCanvasIndex: index)
                                .padding(.bottom, 110)
                                .padding(.horizontal, 32)
                        }
                    }
                }
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)))
    }
    
    @ObservedObject var viewModel: WDSignViewModel
    @Binding public var showModal: Bool
    @Binding public var signatureImages: Array<Image?>
    @Binding public var selectedCanvasIndex: Int
    @Binding public var aware: Bool
}
