//
//  DUTitleLabel.swift
//  DUsers
//
//  Created by Shira Janach on 19/05/2021.
//

import UIKit

class DUTitleLabel: UILabel {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    convenience init(textAlignment: NSTextAlignment, fontSize: CGFloat, weight: DUFontName) {
        self.init(frame: .zero)
        self.textAlignment = textAlignment
        self.font          = UIFont(name: fontName + weight.rawValue, size: fontSize)
    }
    
    
    private func configure() {
        textColor                   = .label
        adjustsFontSizeToFitWidth   = true
        minimumScaleFactor          = 0.9
        lineBreakMode               = .byTruncatingTail
        translatesAutoresizingMaskIntoConstraints = false
        alpha = 0.8
        
        
    }
}
