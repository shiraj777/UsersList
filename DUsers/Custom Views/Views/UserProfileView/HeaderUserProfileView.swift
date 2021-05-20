//
//  HeaderUserProfileView.swift
//  DUsers
//
//  Created by Shira Janach on 19/05/2021.
//

import UIKit

class HeaderUserProfileView: UIView {

    
    let firstNameLabel      = DUTitleLabel(textAlignment: .left, fontSize: 14)
    var topView             = TopHeaderView(frame: .zero)
    var likesView           = UserProfileLikesView(frame: .zero)
     
    var posts: [Post] = []
    var user: User?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemBackground
        configure()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    convenience init(posts: [Post]) {
        self.init(frame: .zero)
        
        self.posts              = posts
        self.user               = posts.count > 0 ? posts[0].owner : nil
        
        guard let user          = user else { return }
        likesView.set(posts: posts)
        topView.set(user: user)
        firstNameLabel.text     = "\(user.firstName ?? "user")'s posts"
    }
    
    
    private func configure() {
        addSubviews(topView, likesView, firstNameLabel)
        
        NSLayoutConstraint.activate([
            topView.topAnchor.constraint(equalTo: self.topAnchor),
            topView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            topView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            topView.heightAnchor.constraint(equalToConstant: 220),
            
            likesView.topAnchor.constraint(equalTo: topView.bottomAnchor, constant: 20),
            likesView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            likesView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 40),
            likesView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -40),
            likesView.heightAnchor.constraint(equalToConstant: 80),

            firstNameLabel.topAnchor.constraint(equalTo: likesView.bottomAnchor, constant: 20),
            firstNameLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            firstNameLabel.heightAnchor.constraint(equalToConstant: 18),
        ])
    }
}
