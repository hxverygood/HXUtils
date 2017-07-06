//
//  ViewController.swift
//  HXUtils
//
//  Created by hoomsun on 2017/7/5.
//  Copyright © 2017年 hoomsun. All rights reserved.
//

import UIKit


class ViewController: UIViewController {
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var lable2: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let str = "Hello World, Hello China"
        let attrStr = str.attributed(from: 5, to: 17, frontSize: 16.0, midSize: 22.0, endSize: 20.0, frontColor: .green, midColor: .red, endColor: .blue)
        label.attributedText = attrStr
        
        let attrStr2 = str.attributed(from: 6, to: 17, size: 22.0, otherSize: 18.0, color: .red, otherColor: .green)
        lable2.attributedText = attrStr2
    }
}

