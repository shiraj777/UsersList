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
    let titleLabel          = DUTitleLabel(textAlignment: .left, fontSize: 16, weight: .bold)
    let subtitleLabel       = DUBodyLabel(textAlignment: .left, fontSize: 14, weight: .lite)
    let likesLabel          = DUBodyLabel(textAlignment: .left, fontSize: 14, weight: .lite)
    let numberOfLikesLabel  = DUTitleLabel(textAlignment: .left, fontSize: 16, weight: .bold)
    let titleStackView      = UIStackView(frame: .zero)
    let likesStackView      = UIStackView(frame: .zero)

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
        configureStackView()
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
    
    
    private func configureStackView() {
        let stackViews = [titleStackView, likesStackView]
        for stackView in stackViews {
            stackView.axis = .vertical
            stackView.distribution = .equalSpacing
            stackView.translatesAutoresizingMaskIntoConstraints = false
            stackView.spacing = screenHeight/200
        }
        
        titleStackView.addArrangedSubview(titleLabel)
        titleStackView.addArrangedSubview(subtitleLabel)
        
        likesStackView.addArrangedSubview(numberOfLikesLabel)
        likesStackView.addArrangedSubview(likesLabel)
    }
    
    
    private func configure() {
        likesLabel.textColor            = DUColors.blue
        numberOfLikesLabel.textColor    = DUColors.blue
        
        addSubviews(avatarImageView, titleStackView, likesStackView)
        
        let padding: CGFloat    = screenWidth/15
        NSLayoutConstraint.activate([
            avatarImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            avatarImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: padding),
            avatarImageView.heightAnchor.constraint(equalToConstant: screenHeight/14),
            avatarImageView.widthAnchor.constraint(equalTo: avatarImageView.heightAnchor),
            
            titleStackView.centerYAnchor.constraint(equalTo: avatarImageView.centerYAnchor),
            titleStackView.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: screenWidth/28),
            titleStackView.trailingAnchor.constraint(equalTo: likesStackView.leadingAnchor, constant: -padding),
  
            likesStackView.centerYAnchor.constraint(equalTo: titleStackView.centerYAnchor),
            likesStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -padding),
            likesStackView.widthAnchor.constraint(equalToConstant: screenWidth/6),
        ])
    }
}

