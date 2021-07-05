import SwiftUI
import PencilKit

public struct ContentView: View {
    @Environment(\.undoManager) public var undoManager
    @State public var canvas = PKCanvasView()
    @State public var isDraw = true
    @State public var colorPicker = false
    @State public var color: Color = .black
    @State public var type: PKInkingTool.InkType = .pen
    
    var documentTemplate: SignDocumentTemplate
    
    public init(documentTemplate: SignDocumentTemplate) {
        self.documentTemplate = documentTemplate
    }
    
    public var body: some View {
        NavigationView {
            ZStack {
                Image(documentTemplate.watermark)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: screenBounds.width / 2)
                    .opacity(0.2)
                    
                
                //Logo
                Image(documentTemplate.logo)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 100, height: 100)
                    .padding(32)
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
                
                SignatureCanvas(canvas: $canvas, isDraw: $isDraw, color: $color, type: $type)
                buildSignatureFieldsTemplate()
                    .padding()
                    .navigationBarItems(leading: navigationBarLeadingButtons, trailing: navigationBarTrailingButtons)
                    .sheet(isPresented: $colorPicker, content: {

                })
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
    
    public var navigationBarLeadingButtons: some View {
        HStack(spacing: 15) {
            Button(action: {
                saveImage()
            }, label: {
                Image(systemName: "square.and.arrow.down.fill")
      
            })
            
            Button(action: {
                eraseCanvas()
            }, label: {
                Image(systemName: "xmark")
                 
            })
            
            Button(action: {
                undoManager?.undo()
            }, label: {
                Image(systemName: "arrow.uturn.left")
                   
            })
        }
    }
    
    public var navigationBarTrailingButtons: some View {
        HStack(spacing: 15) {
            
            Button(action: {
                undoManager?.redo()
            }, label: {
                Image(systemName: "arrow.uturn.right")
                   
            })
            
            Button(action: {
                isDraw.toggle()
            }, label: {
                Image(systemName: isDraw ? "pencil.slash" : "pencil")
                    
            })
        }
    }
    
    var signatureFieldModel: some View {
        ZStack(alignment: .bottom) {
            SignatureCanvas(canvas: $canvas, isDraw: $isDraw, color: $color, type: $type)
                .frame(width: screenBounds.width / 2, height: screenBounds.height / 3, alignment: .center)
            
            Rectangle()
                .foregroundColor(.black)
                .frame(width: screenBounds.width / 2, height: 1, alignment: .center)
                .padding(.bottom, 32)
        }
        .frame(width: screenBounds.width / 2, height: screenBounds.height / 3, alignment: .center)
    }
    
    @ViewBuilder
    public func buildSignatureFieldsTemplate() -> some View {
        if documentTemplate.signatureField2Alignment == "" {
            signatureFieldModel
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: documentTemplate.signatureField1Alignment.convertToAlignment())
        } else {
            if documentTemplate.signatureField1Alignment == documentTemplate.signatureField2Alignment {
                
            } else {
                
            }
        }
    }
    
    public func eraseCanvas() {
        canvas.drawing = PKDrawing()
    }
    
    public func saveImage() {
        let image = canvas.drawing.image(from: canvas.drawing.bounds, scale: 1)
        
        UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
    }
    
    let screenBounds = UIScreen.main.bounds
}

public struct ContentView_Previews: PreviewProvider {
    public static var previews: some View {
        ContentView(documentTemplate: SignDocumentTemplate(id: 0, watermark: "teste", logo: "teste", signatureField1Alignment: "teste", signatureField2Alignment: "testea"))
    }
}

//public struct SignatureCanvas: UIViewRepresentable {
//    @Binding public var canvas: PKCanvasView
//    @Binding public var isDraw: Bool
//    @Binding public var color: Color
//    @Binding public var type: PKInkingTool.InkType
//
//    public var ink: PKInkingTool {
//        PKInkingTool(type, color: UIColor(color), width: 3)
//    }
//
//    public let eraser = PKEraserTool(.bitmap)
//
//    public func makeUIView(context: Context) -> PKCanvasView {
//        canvas.tool = isDraw ? ink : eraser
//        canvas.backgroundColor = .clear
//        return canvas
//    }
//
//    public func updateUIView(_ uiView: PKCanvasView, context: Context) {
//        uiView.tool = isDraw ? ink : eraser
//    }
//}

public struct SignDocumentTemplate: Identifiable {
    public var id: Int
    var watermark: String
    var logo: String
    var signatureField1Alignment: String
    var signatureField2Alignment: String
    
    public init (id: Int, watermark: String, logo: String, signatureField1Alignment: String, signatureField2Alignment: String) {
        self.id = id
        self.watermark = watermark
        self.logo = logo
        self.signatureField1Alignment = signatureField1Alignment
        self.signatureField2Alignment = signatureField2Alignment
    }
}


extension String {
    func convertToAlignment() -> Alignment {
        switch self {
        case "leading": return .bottomLeading
        case "center": return .bottom
        case "trailing": return .bottomTrailing
        default: return .bottomLeading
        }
    }
}
