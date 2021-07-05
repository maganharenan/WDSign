//
//  SwiftUIView.swift
//  
//
//  Created by Nuxen on 05/07/21.
//

import SwiftUI

public struct SignFieldView: View {
    public var body: some View {
        VStack(spacing: 0) {
            Button {
                showSignatureBox(appDelegate: appDelegate)
            } label: {
                Text("Sign")
                    .font(.body)
                    .foregroundColor(Color(#colorLiteral(red: 0.9647058824, green: 0.7568627451, blue: 0.4470588235, alpha: 1)))
                    .frame(maxWidth: .infinity, maxHeight: 44)
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
    
    var appDelegate: UIApplicationDelegate?
    @Binding var showModal: Bool
    
    private func showSignatureBox(appDelegate: UIApplicationDelegate? = nil) {
        guard let appDelegate = appDelegate else { return }
        showModal.toggle()
        
        let modalViewController = UIHostingController(rootView: SignatureBoxView())
        
        modalViewController.isModalInPresentation = true
        modalViewController.modalPresentationStyle = .formSheet

        appDelegate.window??.rootViewController?.present(modalViewController, animated: true)
    }
}

struct SignFieldView_Previews: PreviewProvider {
    static var previews: some View {
        SignFieldView(appDelegate: nil, showModal: .constant(false))
    }
}
