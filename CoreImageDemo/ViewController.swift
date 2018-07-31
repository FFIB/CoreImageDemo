//
//  MirrorController.swift
//  CoreImageDemo
//
//  Created by FFIB on 2018/7/27.
//  Copyright © 2018 FFIB. All rights reserved.
//

import UIKit

class MirrorController: UIViewController {

    @IBOutlet weak var originImageView: UIImageView!
    @IBOutlet weak var mirrorImageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        let image = UIImage.init(named: "1")
        originImageView.image = image
        mirrorImageView.image = image?.mirrorX()
    }
}

