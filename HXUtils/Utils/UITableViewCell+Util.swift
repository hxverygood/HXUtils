//
//  UITableViewCell+Util.swift
//  HXUtils
//
//  Created by hoomsun on 2017/7/6.
//  Copyright © 2017年 hoomsun. All rights reserved.
//

import Foundation
import UIKit

extension UITableViewCell {
    public static func viewHeight() -> CGFloat? {
        let clsName: String? = String(describing: self.self)
        guard let classname = clsName, classname != "UITableViewCell" else {
            return nil
        }
        
        let nib: UINib = UINib(nibName: classname, bundle: nil)
        
        let view: UIView = nib.instantiate(withOwner: nil, options: nil).last as!UIView
        
        
        return view.frame.size.height
    }
}
