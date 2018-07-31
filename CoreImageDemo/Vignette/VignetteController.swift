//
//  VignetteController.swift
//  CoreImageDemo
//
//  Created by FFIB on 2018/7/30.
//  Copyright © 2018 FFIB. All rights reserved.
//

import UIKit
import GLKit

class VignetteController: UIViewController {

    @IBOutlet weak var glkView: GLKView!
    var context: CIContext? = nil
    let filter = VignetteFilter()
    var targetBounds = CGRect.zero
    override func viewDidLoad() {
        super.viewDidLoad()
        let eaglContext = EAGLContext(api: EAGLRenderingAPI.openGLES2)
        glkView.context = eaglContext!
        context = CIContext(eaglContext: eaglContext!)

        filter.inputImage = CIImage(image: UIImage(named: "1")!)

        glkView.layoutIfNeeded()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        targetBounds = aspectFit(fromRect: (filter.inputImage?.extent)!, toRect: CGRect(x: 0, y: 0, width:glkView.drawableWidth, height: glkView.drawableHeight))
        context?.draw(filter.outputImage!, in: targetBounds, from: (filter.inputImage?.extent)!)
        glkView.display()
    }

    @IBAction func alphaChange(_ sender: UISlider) {
        filter.inputAlpha = CGFloat(sender.value)
        context?.draw(filter.outputImage!, in: targetBounds, from: (filter.inputImage?.extent)!)
        glkView.context.presentRenderbuffer(Int(GL_RENDERBUFFER))
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
