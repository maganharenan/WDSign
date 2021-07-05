//
//  SwiftUIView.swift
//  
//
//  Created by Renan Maganha on 21/06/21.
//

import SwiftUI

public struct WDSignDocumentView: View {
    public var body: some View {
        VStack(spacing: 0) {
            /// Navigation  bar
            HStack {
                Button(action: {
                    self.presentationMode.wrappedValue.dismiss()
                }, label: {
                    Text("Cancel")
                        .font(.body)
                        .foregroundColor(Color(#colorLiteral(red: 0.9176470588, green: 0.462745098, blue: 0.4078431373, alpha: 1)))
                        .frame(width: 100, height: 44)
                })
                
                Text(documentLayoutInfo?.title ?? "")
                    .font(.title2)
                    .foregroundColor(Color(#colorLiteral(red: 0.2352941176, green: 0.4117647059, blue: 0.4980392157, alpha: 1)))
                    .frame(maxWidth: .infinity)
                
                Button(action: {
                    
                }, label: {
                    Text("Save")
                        .font(.headline)
                        .foregroundColor(Color(#colorLiteral(red: 0.4549019608, green: 0.7333333333, blue: 0.7098039216, alpha: 1)))
                        .frame(width: 100, height: 44)
                })
            }
            .frame(maxWidth: .infinity, maxHeight: 50)
            
            /// Document layout
            ZStack {
                if let backgroundWatermark = documentLayoutInfo?.watermark {
                    Image(backgroundWatermark)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .aspectRatio(contentMode: .fit)
                }
                
                VStack(spacing: 0) {
                    Text(documentLayoutInfo.documentText)
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
                
                    SignFieldView(appDelegate: appDelegate, showModal: $showModal)
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color(#colorLiteral(red: 0.9333333333, green: 0.9529411765, blue: 0.9607843137, alpha: 1)))
        }
        .navigationBarHidden(true)
    }
    
    var documentLayoutInfo: SignDocumentLayoutInfo!
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @State var showModal = false
    var appDelegate: UIApplicationDelegate?
    
    public init(documentID: Int, appDelegate: UIApplicationDelegate?) {
        self.documentLayoutInfo = WDSignDAO.instance.fetchDocumentInformations(documentID: documentID)
        self.appDelegate = appDelegate
    }
}

struct WDSignDocumentView_Previews: PreviewProvider {
    static var previews: some View {
        WDSignDocumentView(documentID: 1, appDelegate: nil)
    }
}
