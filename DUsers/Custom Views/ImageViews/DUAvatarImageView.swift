//
//  DUAvatarImageView.swift
//  DUsers
//
//  Created by Shira Janach on 19/05/2021.
//

import UIKit

class DUAvatarImageView: UIImageView {

    let placeholderImage = Images.placeholder
    let cache            = NetworkManager.shared.cache
    var isNotCircle      = false
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(isNotCircle: Bool) {
        self.init(frame: .zero)
        self.isNotCircle = isNotCircle
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = frame.size.height / 2
        clipsToBounds = !isNotCircle
    }
    
    private func configure() {
        image = isNotCircle ? placeholderImage : nil
        translatesAutoresizingMaskIntoConstraints = false
    }
}
