//
//  UIViewController+Ext.swift
//  DUsers
//
//  Created by Shira Janach on 19/05/2021.
//

import UIKit

let screenSize = UIScreen.main.bounds
let screenWidth = screenSize.width
let screenHeight = screenSize.height

extension UIViewController {
    
    func presentGFAlertOnMinThread(title: String, message: String, buttonTitle: String) {
        DispatchQueue.main.async {
            let alertVC = DUAlertVC(title: title, message: message, buttonTitle: buttonTitle)
            alertVC.modalPresentationStyle = .overFullScreen
            alertVC.modalTransitionStyle = .crossDissolve
            self.present(alertVC, animated: true)
        }
    }
    
    @objc func shareButtonTapped() {
        if let name = URL(string: "https://itunes.apple.com/us/app/myapp/idxxxxxxxx?ls=1&mt=8"), !name.absoluteString.isEmpty {
          let objectsToShare = [name]
          let activityVC = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)
          self.present(activityVC, animated: true, completion: nil)
        } else {
          // show alert for not available
        }
    }
}
