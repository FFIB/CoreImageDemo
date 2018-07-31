//
//  VignetteFilter.swift
//  CoreImageDemo
//
//  Created by FFIB on 2018/7/30.
//  Copyright © 2018 FFIB. All rights reserved.
//

import UIKit

class VignetteFilter: CIFilter {
    fileprivate var custmKernel: CIColorKernel? = nil
    var inputImage: CIImage? = nil
    var inputAlpha: CGFloat = 0.0
    override var outputImage: CIImage? {
        guard let inputImage = inputImage else { return nil }
        let rect = inputImage.extent
        let center = CIVector(x: rect.width / 2, y: rect.height / 2)
        let res =  custmKernel?.apply(extent: inputImage.extent, arguments: [inputImage, center, rect.width / 2, inputAlpha])
        return res
    }

    override init() {
        super.init()
        let bundle = Bundle(for: self.classForCoder)
        guard let kernelURL = bundle.url(forResource: "Vignette", withExtension: "cikernel"),
            let kernerlCode = try?String(contentsOf: kernelURL),
            let kernels = CIKernel.makeKernels(source: kernerlCode) else {
                abort()
        }
        custmKernel = kernels[0] as? CIColorKernel
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
