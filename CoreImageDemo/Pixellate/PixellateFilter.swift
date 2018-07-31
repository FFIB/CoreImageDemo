//
//  PixellateFilter.swift
//  CoreImageDemo
//
//  Created by FFIB on 2018/7/30.
//  Copyright © 2018 FFIB. All rights reserved.
//

import UIKit

class PixellateFilter: CIFilter {
    var custmKernel: CIWarpKernel? = nil
    var inputImage: CIImage? = nil
    var inputRadio: CGFloat = 0

    override var outputImage: CIImage? {
        guard let inputImage = inputImage else { return nil }
        let inputWidth = inputImage.extent.size.width
        let res = custmKernel?.apply(extent: CGRect(x: inputImage.extent.origin.y,
                                                    y: inputImage.extent.origin.x,
                                                    width: inputImage.extent.height,
                                                    height: inputImage.extent.width),
                                     roiCallback: { (index, rect) -> CGRect in
                                        return CGRect(x: rect.origin.y,
                                                      y: rect.origin.x,
                                                      width: rect.height,
                                                      height: rect.width)
        },
                                     image: inputImage,
                                     arguments: [inputRadio])
        return res
    }

    override init() {
        super.init()
        let bundle = Bundle(for: self.classForCoder)
        guard let kernelURL = bundle.url(forResource: "Pixellate", withExtension: "cikernel"),
            let kernerlCode = try?String(contentsOf: kernelURL),
            let kernels = CIKernel.makeKernels(source: kernerlCode) else {
                abort()
        }
        custmKernel = kernels[0] as? CIWarpKernel
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

