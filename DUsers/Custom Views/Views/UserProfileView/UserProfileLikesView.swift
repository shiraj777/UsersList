//
//  UserProfileLikesView.swift
//  DUsers
//
//  Created by Shira Janach on 19/05/2021.
//

import UIKit

class UserProfileLikesView: UIView {

    let totalLikesIcon      = DUAvatarImageView(isNotCircle: true)
    let numberOfLikesLabel  = DUTitleLabel(textAlignment: .left, fontSize: 18, weight: .extrabold)
    let likesLabel          = DUTitleLabel(textAlignment: .center, fontSize: 13, weight: .bold)
    let stackView           = UIStackView(frame: .zero)

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
        
        totalLikesIcon.image = Images.totalLicksIcon
        totalLikesIcon.clipsToBounds = false
    }
    
    private func configure() {
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.addArrangedSubview(likesLabel)
        stackView.addArrangedSubview(numberOfLikesLabel)
        
        addSubviews(stackView, totalLikesIcon)
        
        
        NSLayoutConstraint.activate([
            
            stackView.centerXAnchor.constraint(equalTo: centerXAnchor, constant: -20),
            stackView.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            totalLikesIcon.centerYAnchor.constraint(equalTo: centerYAnchor),
            totalLikesIcon.leadingAnchor.constraint(equalTo: stackView.trailingAnchor, constant: 8),
            totalLikesIcon.heightAnchor.constraint(equalToConstant: screenHeight/28),
            totalLikesIcon.widthAnchor.constraint(equalTo: totalLikesIcon.heightAnchor, constant: screenWidth/80),
        ])
    }
}
