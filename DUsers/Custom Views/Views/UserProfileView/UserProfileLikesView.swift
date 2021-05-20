//
//  UserProfileLikesView.swift
//  DUsers
//
//  Created by Shira Janach on 19/05/2021.
//

import UIKit

class UserProfileLikesView: UIView {

    let numberOfLikesLabel = DUTitleLabel(textAlignment: .left, fontSize: 14)
    let likesLabel = DUTitleLabel(textAlignment: .center, fontSize: 14)

    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints   = false
        backgroundColor              = .white
        layer.cornerRadius           = 10
        clipsToBounds                = true
        layer.shadowRadius           = 5
        layer.shadowOffset           = .zero
        layer.shadowOpacity          = 0.2
        layer.shadowColor            = UIColor.black.cgColor
        layer.masksToBounds          = false

        
        numberOfLikesLabel.textColor = DUColors.blue
        configure()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(posts: [Post]) {
        likesLabel.text         = "Total likes"
        let numberOfLikesArray  = posts.map({$0.likes ?? 0})
        
        let numberOfLikes       = numberOfLikesArray.reduce(0, +)
        numberOfLikesLabel.text = "\(numberOfLikes)"
        
    }
    
    private func configure() {
        addSubviews(likesLabel, numberOfLikesLabel)
        
        NSLayoutConstraint.activate([
            likesLabel.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            likesLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            likesLabel.heightAnchor.constraint(equalToConstant: 16),
            
            numberOfLikesLabel.topAnchor.constraint(equalTo: likesLabel.bottomAnchor, constant: 5),
            numberOfLikesLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            numberOfLikesLabel.heightAnchor.constraint(equalToConstant: 16)
        ])
    }
}
