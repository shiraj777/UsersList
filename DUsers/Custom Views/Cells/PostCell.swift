//
//  PostCell.swift
//  DUsers
//
//  Created by Shira Janach on 19/05/2021.
//

import UIKit

class PostCell: UITableViewCell {

    static let reuseID      = "PostCell"
    let avatarImageView     = DUAvatarImageView(frame: .zero)
    let titleLabel          = DUTitleLabel(textAlignment: .left, fontSize: 18, weight: .bold)
    let subtitleLabel       = DUBodyLabel(textAlignment: .left, fontSize: 16, weight: .lite)
    let likesLabel          = DUBodyLabel(textAlignment: .left, fontSize: 16, weight: .lite)
    let numberOfLikesLabel  = DUTitleLabel(textAlignment: .left, fontSize: 18, weight: .bold)

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func set(post: Post) {
        titleLabel.text         = post.text
        subtitleLabel.text      = post.publishDate.convertToDisplayFormat()
        numberOfLikesLabel.text = "\(post.likes ?? 0)"
        likesLabel.text         = "Likes"
       
        guard let picture       = post.image else { return }
        NetworkManager.shared.downloadImage(from: picture) { [weak self] image in
            guard let self = self else { return }
            DispatchQueue.main.async { self.avatarImageView.image = image }
        }
    }
    
    
    private func configure() {
        likesLabel.textColor            = DUColors.blue
        numberOfLikesLabel.textColor    = DUColors.blue
        
        addSubviews(avatarImageView, titleLabel, subtitleLabel, numberOfLikesLabel, likesLabel)
        
        let padding: CGFloat = 20
        
        NSLayoutConstraint.activate([
            avatarImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            avatarImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 30),
            avatarImageView.heightAnchor.constraint(equalToConstant: 60),
            avatarImageView.widthAnchor.constraint(equalToConstant: 60),
            
            titleLabel.topAnchor.constraint(equalTo: avatarImageView.topAnchor, constant: 4),
            titleLabel.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: 12),
            titleLabel.trailingAnchor.constraint(equalTo: numberOfLikesLabel.leadingAnchor, constant: -padding),
            
            subtitleLabel.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: 12),
            subtitleLabel.bottomAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: -4),
            subtitleLabel.widthAnchor.constraint(equalToConstant: frame.width / 2),
            
            numberOfLikesLabel.centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor),
            numberOfLikesLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -30),
            numberOfLikesLabel.widthAnchor.constraint(equalToConstant: 50),
            
            likesLabel.leadingAnchor.constraint(equalTo: numberOfLikesLabel.leadingAnchor),
            likesLabel.trailingAnchor.constraint(equalTo: numberOfLikesLabel.trailingAnchor),
            likesLabel.centerYAnchor.constraint(equalTo: subtitleLabel.centerYAnchor),
        ])
    }
}

