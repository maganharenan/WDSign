//
//  SwiftUIView.swift
//  
//
//  Created by Nuxen on 05/07/21.
//

import SwiftUI
import PencilKit

public struct SignFieldView: View {
    public var body: some View {
        VStack(spacing: 0) {
            Button {
                showSignatureBox()
            } label: {
                HStack {
                    if let signatureImage = signatureImage {
                        signatureImage
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(maxWidth: 270, maxHeight: 88)
                    } else {
                        Text(Constants.SystemResources.Sign.translateResource())
                            .font(.headline)
                            .foregroundColor(AppColorsDAO.instance.system_color_16.getColorFromHex())
                            .frame(maxWidth: .infinity, maxHeight: 44)
                        
                    }
                }
                .frame(height: 88, alignment: .bottom)
            }
            
            Rectangle()
                .frame(height: 3)

            Text(subscriber.name)
                .font(.system(size: 15, weight: .semibold))
                .frame(maxWidth: .infinity, alignment: .leading)
            
            if !subscriber.jobTitle.isEmpty {
                Text(subscriber.jobTitle)
                    .font(.footnote)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            
            Text(subscriber.document)
                .font(.footnote)
                .frame(maxWidth: .infinity, alignment: .leading)
        }
        .frame(width: 270, height: 104)
    }

    @Binding var selectedCanvasIndex: Int
    @Binding var showModal: Bool
    @Binding public var signatureImage: Image?
    var subscriber: SubscriberData
    var currentCanvasIndex: Int
    
    private func showSignatureBox() {
        selectedCanvasIndex = currentCanvasIndex
        showModal.toggle()
    }
}

struct SignFieldView_Previews: PreviewProvider {
    static var previews: some View {
        SignFieldView(selectedCanvasIndex: .constant(0), showModal: .constant(false), signatureImage: .constant(Image(systemName: "")), subscriber: SubscriberData(name: "", jobTitle: "", document: ""), currentCanvasIndex: 0)
    }
}
