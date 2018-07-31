//
//  VignetteImage.swift
//  CoreImageDemo
//
//  Created by FFIB on 2018/7/30.
//  Copyright © 2018 FFIB. All rights reserved.
//

import UIKit

extension UIImage {
    func vignette() -> UIImage? {
        let toCiImage = CIImage(image: self)
        let filter = VignetteFilter()
        filter.inputImage = toCiImage
        guard let outputImage = filter.outputImage else { return nil }
        let context = CIContext(options: nil)
        let toCgImage = context.createCGImage(outputImage, from: outputImage.extent)
        return UIImage(cgImage: toCgImage!)
    }
}
