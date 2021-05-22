//
//  UserCell.swift
//  DUsers
//
//  Created by Shira Janach on 19/05/2021.
//

import UIKit

class UserCell: UITableViewCell {

    static let reuseID  = "UserCell"
    let avatarImageView = DUAvatarImageView(frame: .zero)
    let usernameLabel   = DUTitleLabel(textAlignment: .left, fontSize: 16, weight: .bold)

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func set(user: User) {
        usernameLabel.text  = "\(user.firstName ?? "") \(user.lastName ?? "")"
        guard let picture   = user.picture else { return }
        NetworkManager.shared.downloadImage(from: picture) { [weak self] image in
            guard let self = self else { return }
            DispatchQueue.main.async { self.avatarImageView.image = image }
        }
    }
    
    
    private func configure() {
        addSubviews(avatarImageView, usernameLabel)
        
        accessoryType           = .disclosureIndicator
        let padding: CGFloat    = screenWidth/15
        
        NSLayoutConstraint.activate([
            avatarImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            avatarImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: padding),
            avatarImageView.heightAnchor.constraint(equalToConstant: screenHeight/14),
            avatarImageView.widthAnchor.constraint(equalTo: avatarImageView.heightAnchor),
            
            usernameLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            usernameLabel.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: screenWidth/28),
            usernameLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -padding),
        ])
    }
}

