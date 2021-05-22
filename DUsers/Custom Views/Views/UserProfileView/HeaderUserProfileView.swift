//
//  HeaderUserProfileView.swift
//  DUsers
//
//  Created by Shira Janach on 19/05/2021.
//

import UIKit

class HeaderUserProfileView: UIView {

    let firstNameLabel      = DUTitleLabel(textAlignment: .left, fontSize: 16, weight: .extrabold)
    var topView             = TopHeaderView(frame: .zero)
    var likesView           = UserProfileLikesView(frame: .zero)
    var circleView          = UIView(frame: .zero)
     
    var posts: [Post] = []
    var user: User?
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemBackground
        translatesAutoresizingMaskIntoConstraints = false
        configure()
        configureCircleView()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func set(posts: [Post]) {        
        self.posts              = posts
        self.user               = posts.count > 0 ? posts[0].owner : nil
        
        guard let user          = user else { return }
        likesView.set(posts: posts)
        topView.set(user: user)
        firstNameLabel.text     = "\(user.firstName ?? "user")'s posts"
    }
    
    
    func configureCircleView() {
        circleView.backgroundColor = .systemBackground
        circleView.translatesAutoresizingMaskIntoConstraints   = false
        circleView.layer.cornerRadius = 50
        circleView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
    
    }
    
    
    private func configure() {
        addSubviews(topView, circleView, likesView, firstNameLabel)
                
        NSLayoutConstraint.activate([
            topView.topAnchor.constraint(equalTo: topAnchor),
            topView.leadingAnchor.constraint(equalTo: leadingAnchor),
            topView.trailingAnchor.constraint(equalTo: trailingAnchor),
            topView.heightAnchor.constraint(equalToConstant: screenHeight/2.7),
            
            circleView.topAnchor.constraint(equalTo: topView.bottomAnchor, constant: -screenHeight/14),
            circleView.centerXAnchor.constraint(equalTo: centerXAnchor),
            circleView.widthAnchor.constraint(equalToConstant: screenWidth),
            circleView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -100),
            
            likesView.topAnchor.constraint(equalTo: topView.bottomAnchor, constant: -screenHeight/45),
            likesView.centerXAnchor.constraint(equalTo: centerXAnchor),
            likesView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 40),
            likesView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -40),
            likesView.heightAnchor.constraint(equalToConstant: screenHeight/9),

            firstNameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 30),
            firstNameLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -screenHeight/70)
        ])
    }
}
