//
//  SwiftUIView.swift
//  
//
//  Created by Renan Maganha on 21/06/21.
//

import SwiftUI
import PencilKit

enum SubscriberType: String {
    case User = "Usuário"
    case Manager = "Gerente"
    case UserAndManager = "Usuário e gerente"
    case UserAndSubordinate = "Usuário e subordinado"
    case Form = "Formulário"
    case UserAndForm = "Usuário e formulário"
    case Subordinate = "Subordinado"

    var numberOfSignatureFields: Int {
        switch self {
        case .User: return 1
        case .Manager: return 1
        case .UserAndManager: return 2
        case .UserAndSubordinate: return 2
        case .Form: return 1
        case .UserAndForm: return 2
        case .Subordinate: return 1
        }
    }
}

public struct WDSignDocumentView: View {
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
        SubscriberType.init(rawValue: documentLayoutInfo.subscriberTypeDescription)?.numberOfSignatureFields ?? 1
    }
}



extension View {
    func snapshot() -> UIImage {
        let controller = UIHostingController(rootView: self)
        let view = controller.view

        let targetSize = CGSize(width: 1024, height: 768)
        view?.bounds = CGRect(origin: .zero, size: targetSize)
        view?.backgroundColor = .clear

        let renderer = UIGraphicsImageRenderer(size: targetSize)

        return renderer.image { _ in
            view?.drawHierarchy(in: controller.view.bounds, afterScreenUpdates: true)
        }
    }
}

extension UIImage {
    func saveImageOnDocuments(completion: @escaping (Bool) -> Void) {
        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        // choose a name for your image
        let fileName = "image.jpg"
        // create the destination file url to save your image
        let fileURL = documentsDirectory.appendingPathComponent(fileName)
        // get your UIImage jpeg data representation and check if the destination file url already exists
        if let data = self.pngData(),
           !FileManager.default.fileExists(atPath: fileURL.path) {
            do {
                // writes the image data to disk
                try data.write(to: fileURL)
                print("file saved")
                completion(true)
            } catch {
                print("error saving file:", error)
                completion(true)
            }
        } else {
            completion(true)
        }
    }
}
