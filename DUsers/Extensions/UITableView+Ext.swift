//
//  UITableView+Ext.swift
//  DUsers
//
//  Created by Shira Janach on 19/05/2021.
//

import UIKit

extension UITableView {
    
    func reloadDataOnMainThread() {
        DispatchQueue.main.async { self.reloadData() }
    }
    
    
    func removeExcessCells() {
        tableFooterView = UIView(frame: .zero)
    }
    
    
}
