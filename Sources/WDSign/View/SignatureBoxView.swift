//
//  SignatureBoxVIew.swift
//  
//
//  Created by Renan Maganha on 05/07/21.
//

import SwiftUI
import PencilKit

struct SignatureBoxView: View {
    var body: some View {
        ZStack(alignment: .center){
            Color(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1))
                .opacity(showModal ? 0.1 : 0)
                .animation(.easeInOut)
            
            VStack(spacing: 0) {
                HStack(spacing: 0) {
                    Button(action: {
                        cancelSignature()
                    }, label: {
                        Text(Constants.SystemResources.Cancel.translateResource())
                            .font(.body)
                            .foregroundColor(AppColorsDAO.instance.system_color_14.getColorFromHex())
                            .frame(width: 85, height: 44, alignment: .center)
                    })
                    
                    Text(Constants.SystemResources.SignHere.translateResource())
                        .foregroundColor(AppColorsDAO.instance.system_color_7.getColorFromHex())
                        .frame(maxWidth: .infinity, maxHeight: 44)
                    
                    Button(action: {
                        saveSignature()
                    }, label: {
                        Text(Constants.SystemResources.Save.translateResource())
                            .font(.headline)
                            .foregroundColor(AppColorsDAO.instance.system_color_15.getColorFromHex())
                            .frame(width: 85, height: 44, alignment: .center)
                    })
                }
                .frame(maxWidth: .infinity, maxHeight: 50)
                .background(AppColorsDAO.instance.system_color_3.getColorFromHex())
                .gesture(returnGesture())
                
                ZStack {
                    SignatureCanvas(canvas: $canvas)
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
                    
                    Rectangle()
                        .frame(width: 456, height: 3, alignment: .center)
                        .foregroundColor(AppColorsDAO.instance.system_color_7.getColorFromHex())
                        .padding(.bottom, 28)
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                
                Button(action: {
                    eraseCanvas()
                }, label: {
                    Text(Constants.SystemResources.Clean.translateResource())
                        .font(.body)
                        .foregroundColor(AppColorsDAO.instance.system_color_7.getColorFromHex())
                        .frame(width: 85, height: 44, alignment: .center)
                })
                .frame(maxWidth: .infinity, alignment: .trailing)
            }
            .frame(width: 540, height: 343, alignment: .center)
            .background(Color.white)
            .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
            .position(x: screen.width / 2, y: showModal ? (screen.height / 2) + dragGesturePosition : UIScreen.main.bounds.height + 200)
            .animation(.easeInOut)
        }
    }
    
    @State var canvas = PKCanvasView()
    @Binding public var bindcanvas: PKCanvasView
    @Binding public var showModal: Bool
    @Binding public var signatureImage: Image?
    @State var dragGesturePosition: CGFloat = 0
    var storedCanvas: PKDrawing
    private var screen = UIScreen.main.bounds
    
    init(canvas: Binding<PKCanvasView>, showModal: Binding<Bool>, signatureImage: Binding<Image?>) {
        self._bindcanvas = canvas
        self.storedCanvas = canvas.wrappedValue.drawing
        self._showModal = showModal
        self._signatureImage = signatureImage
    }
    
    private func eraseCanvas() {
        canvas.drawing = PKDrawing()
    }
    
    private func cancelSignature() {
        canvas.drawing = storedCanvas
        showModal.toggle()
        dragGesturePosition = 0
    }
    
    private func saveSignature() {
        bindcanvas = canvas
        let imageArea: CGRect = canvas.drawing.bounds
        signatureImage = Image(uiImage: canvas.drawing.image(from: imageArea, scale: 1))
        
        showModal.toggle()
    }
    
    func returnGesture() -> some Gesture {
        DragGesture()
            .onChanged { value in
                if value.translation.height / 10 > 0 {
                    dragGesturePosition += (value.translation.height / 10)
                    if dragGesturePosition >= 300 {
                        cancelSignature()
                    }
                }
            }
            .onEnded { value in
                dragGesturePosition = .zero
            }
    }
}

struct SignatureBoxView_Previews: PreviewProvider {
    static var previews: some View {
        SignatureBoxView(canvas: .constant(PKCanvasView()), showModal: .constant(true), signatureImage: .constant(Image(systemName: "")))
            .previewLayout(.fixed(width: 1024, height: 768))
    }
}
