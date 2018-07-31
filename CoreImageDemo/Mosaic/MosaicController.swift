//
//  MosaicController.swift
//  CoreImageDemo
//
//  Created by FFIB on 2018/7/30.
//  Copyright © 2018 FFIB. All rights reserved.
//

import UIKit
import GLKit

class MosaicController: UIViewController {

    @IBOutlet weak var glkView: GLKView!
    var context: CIContext? = nil
    let filter = MosaicFilter()
    var inputImage = CIImage(image: UIImage(named: "1")!)
    var targetBounds = CGRect.zero
    override func viewDidLoad() {
        super.viewDidLoad()
        let eaglContext = EAGLContext(api: EAGLRenderingAPI.openGLES2)
        glkView.context = eaglContext!
        context = CIContext(eaglContext: eaglContext!)
        filter.inputImage = inputImage
        filter.inputMaskImage = CIImage(image: UIImage(named: "mosaic_asset_2")!)
        filter.inputRadio = 35
        glkView.layoutIfNeeded()
        viewDidLayoutSubviews()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        targetBounds = aspectFit(fromRect: (filter.inputImage?.extent)!, toRect: CGRect(x: 0, y: 0, width:glkView.drawableWidth, height: glkView.drawableHeight))

        context?.draw(filter.outputImage!, in: targetBounds, from: (filter.inputImage?.extent)!)
        glkView.display()
    }

    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        var point = touch.location(in: glkView)
        point.y = glkView.frame.height - point.y
        point = converPointToImagePoint(point: point)
        let vector = CIVector(cgPoint: point)

        let cgImage = context?.createCGImage(filter.outputImage!, from: (filter.outputImage?.extent)!)
        inputImage = CIImage(cgImage: cgImage!)

        filter.inputImage = inputImage
        filter.inputPoint = vector
        context?.draw(filter.outputImage!, in: targetBounds, from: (inputImage?.extent)!)
        glkView.context.presentRenderbuffer(Int(GL_RENDERBUFFER))
    }

    func converPointToImagePoint(point: CGPoint) -> CGPoint {
        var imagePoint = CGPoint.zero
        let scale = (inputImage?.extent.width)! / targetBounds.width

        imagePoint.x = (point.x * UIScreen.main.scale - targetBounds.origin.x) * scale
        imagePoint.y = (point.y * UIScreen.main.scale - targetBounds.origin.y) * scale

        return imagePoint
    }

    func aspectFit(fromRect: CGRect, toRect: CGRect) -> CGRect {
        let fromAspectRatio = fromRect.width / fromRect.height
        let toAspectRatio = toRect.width / toRect.height

        var fitRect = toRect

        if fromAspectRatio > toAspectRatio {
            fitRect.size.height = toRect.size.width / fromAspectRatio
            fitRect.origin.y += (toRect.size.height - fitRect.size.height) * 0.5
        } else {
            fitRect.size.height = toRect.size.height * fromAspectRatio
            fitRect.origin.y += (toRect.size.width - fitRect.size.width) * 0.5
        }

        return fitRect.integral
    }
}
