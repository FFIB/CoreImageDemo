//
//  MosaicFilter.swift
//  CoreImageDemo
//
//  Created by FFIB on 2018/7/30.
//  Copyright © 2018 FFIB. All rights reserved.
//

import UIKit

class MosaicFilter: CIFilter {
    var custmKernel: CIKernel? = nil
    var inputImage: CIImage? = nil
    var inputMaskImage: CIImage? = nil
    var inputRadio: CGFloat = 0
    var inputPoint = CIVector(x: 0, y: 0)

    override var outputImage: CIImage? {
        guard let inputImage = inputImage, let inputMaskImage = inputMaskImage else { return nil }
        let res = custmKernel?.apply(extent: inputImage.extent,
                                     roiCallback: { (index, rect) -> CGRect in
                                        if index == 0 {
                                            return inputImage.extent
                                        } else {
                                            return inputMaskImage.extent
                                        }
        },
                                     arguments: [inputImage, inputMaskImage, inputRadio, inputPoint, inputMaskImage.extent.width, inputMaskImage.extent.height])
        return res
    }

    override init() {
        super.init()
        let bundle = Bundle(for: self.classForCoder)
        guard let kernelURL = bundle.url(forResource: "Mosaic", withExtension: "cikernel"),
            let kernerlCode = try?String(contentsOf: kernelURL),
            let kernels = CIKernel.makeKernels(source: kernerlCode) else {
                abort()
        }
        custmKernel = kernels[0]
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
