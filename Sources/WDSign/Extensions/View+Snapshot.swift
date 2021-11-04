//
//  View+Snapshot.swift
//  
//
//  Created by Renan Maganha on 07/07/21.
//

import SwiftUI

extension View {
    /// This function takes a snapshot of the view
    /// - Warning: The returned image is not localized.
    /// - Returns: A screenshot of the view as an UIImage.
    func snapshot(with size: CGSize) -> UIImage {
        let controller = UIHostingController(rootView: self)
        let view = controller.view

        let targetSize = CGSize(width: size.width, height: size.height)
        view?.bounds = CGRect(origin: .zero, size: targetSize)
        view?.backgroundColor = .white

        let renderer = UIGraphicsImageRenderer(size: targetSize)

        return renderer.image { _ in
            view?.drawHierarchy(in: controller.view.bounds, afterScreenUpdates: true)
        }
    }
}
