//
//  SwiftUIView.swift
//  
//
//  Created by Nuxen on 05/07/21.
//

import SwiftUI
import PencilKit

struct SignatureBoxView: View {
    var body: some View {
        ZStack{
            Color(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1))
                .opacity(0.1)
            
            VStack(spacing: 0) {
                HStack(spacing: 0) {
                    Button(action: {
                        cancelSignature()
                    }, label: {
                        Text("Cancel")
                            .frame(width: 85, height: 44, alignment: .center)
                    })
                    
                    Text("Sign here")
                        .frame(maxWidth: .infinity, maxHeight: 44)
                    
                    Button(action: {
                        saveSignature()
                    }, label: {
                        Text("Save")
                            .font(.headline)
                            .frame(width: 85, height: 44, alignment: .center)
                    })
                }
                .frame(maxWidth: .infinity, maxHeight: 50)
                .background(Color(#colorLiteral(red: 0.8666666667, green: 0.9058823529, blue: 0.9254901961, alpha: 1)))
                
                ZStack {
                    SignatureCanvas(canvas: $canvas)
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
                    
                    Rectangle()
                        .frame(width: 456, height: 3, alignment: .center)
                        .padding(.bottom, 28)
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                
                Button(action: {
                    eraseCanvas()
                }, label: {
                    Text("Clear")
                        .frame(width: 85, height: 44, alignment: .center)
                })
                .frame(maxWidth: .infinity, alignment: .trailing)
            }
            .frame(width: 540, height: 343, alignment: .center)
            .background(Color.white)
            .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
        }
    }
    
    @Binding public var canvas: PKCanvasView
    @Binding public var showModal: Bool
    @Binding public var signatureImage: Image?
    
    private func eraseCanvas() {
        canvas.drawing = PKDrawing()
    }
    
    private func cancelSignature() {
        showModal.toggle()
    }
    
    private func saveSignature() {
        let imageArea: CGRect = canvas.drawing.bounds
        signatureImage = Image(uiImage: canvas.drawing.image(from: imageArea, scale: 1))
        
        showModal.toggle()
    }
}

struct SignatureBoxView_Previews: PreviewProvider {
    static var previews: some View {
        SignatureBoxView(canvas: .constant(PKCanvasView()), showModal: .constant(true), signatureImage: .constant(Image(systemName: "")))
            .previewLayout(.fixed(width: 1024, height: 768))
    }
}

public struct SignatureCanvas: UIViewRepresentable {
    @Binding public var canvas: PKCanvasView

    public var ink: PKInkingTool {
        PKInkingTool(.pen, color: .black, width: 7)
    }

    public func makeUIView(context: Context) -> PKCanvasView {
        canvas.drawingPolicy = .anyInput
        canvas.tool = ink
        canvas.backgroundColor = .white
        return canvas
    }

    public func updateUIView(_ uiView: PKCanvasView, context: Context) {
        uiView.tool = ink
    }
}
