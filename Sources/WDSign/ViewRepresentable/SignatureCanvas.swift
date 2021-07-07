//
//  SignatureCanvas.swift
//  
//
//  Created by Renan Maganha on 07/07/21.
//

import SwiftUI
import PencilKit

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
