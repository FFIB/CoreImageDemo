//
//  MirrorImage.swift
//  CoreImageDemo
//
//  Created by FFIB on 2018/7/27.
//  Copyright © 2018 FFIB. All rights reserved.
//

import UIKit

extension UIImage {
    func mirrorX() -> UIImage? {
        let toCiImage = CIImage(image: self)

        let filter = MirrorXFilter()
        filter.inputImage = toCiImage
        guard let outputImage = filter.outputImage else { return nil }

        let context = CIContext(options: nil)
        let toCgImage = context.createCGImage(outputImage, from: outputImage.extent)
        return UIImage(cgImage: toCgImage!)
    }
}
