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

        let targetSize = CGSize(width: size.width, height: size.height - getTopSafeAreaInset())
        view?.bounds = CGRect(origin: CGPoint(x: 0, y: getTopSafeAreaInset()), size: targetSize)
        view?.backgroundColor = .red

        let renderer = UIGraphicsImageRenderer(size: targetSize)

        return renderer.image { _ in
            view?.drawHierarchy(in: CGRect(origin: CGPoint(x: 0, y: getTopSafeAreaInset()), size: targetSize), afterScreenUpdates: true)
        }
    }

    private func getTopSafeAreaInset() -> CGFloat {
        let window = UIApplication.shared.windows.first
        let topPadding = window?.safeAreaInsets.top

        guard let topPadding = topPadding else { return 0.0 }

        return topPadding
    }

}
