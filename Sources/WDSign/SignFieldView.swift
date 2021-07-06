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
                if let signatureImage = signatureImage {
                   signatureImage
                       .resizable()
                       .frame(maxWidth: 270, maxHeight: 88)
                } else {
                    Text("Sign")
                        .font(.body)
                        .foregroundColor(Color(#colorLiteral(red: 0.9647058824, green: 0.7568627451, blue: 0.4470588235, alpha: 1)))
                        .frame(maxWidth: .infinity, maxHeight: 44)
                }
            }
            
            Rectangle()
                .frame(height: 3)

            Text("Name")
                .font(.system(size: 15, weight: .semibold))
                .frame(maxWidth: .infinity, alignment: .leading)
            
            Text("Role")
                .font(.footnote)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            Text("Document")
                .font(.footnote)
                .frame(maxWidth: .infinity, alignment: .leading)
        }
        .frame(width: 270, height: 104)
    }

    @Binding var showModal: Bool
    @Binding public var canvas: PKCanvasView
    @Binding public var signatureImage: Image?
    
    private func showSignatureBox() {
        showModal.toggle()
    }
}

struct SignFieldView_Previews: PreviewProvider {
    static var previews: some View {
        SignFieldView(showModal: .constant(false), canvas: .constant(PKCanvasView()), signatureImage: .constant(Image(systemName: "")))
    }
}

extension PKDrawing {
    
    func isEmpty() -> Bool {
        return strokes.isEmpty
    }
}
