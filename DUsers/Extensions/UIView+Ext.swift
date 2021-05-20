//
//  UIView+Ext.swift
//  DUsers
//
//  Created by Shira Janach on 19/05/2021.
//

import UIKit

extension UIView {
    func addSubviews(_ views: UIView...) {
        for view in views {
            addSubview(view)
        }
    }
}
