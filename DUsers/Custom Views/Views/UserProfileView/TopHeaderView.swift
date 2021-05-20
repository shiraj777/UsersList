//
//  TopHeaderView.swift
//  DUsers
//
//  Created by Shira Janach on 19/05/2021.
//

import UIKit

class TopHeaderView: UIView {

    let profilreImageView   = DUAvatarImageView(frame: .zero)
    let fullNameLabel       = DUTitleLabel(textAlignment: .center, fontSize: 20, weight: .extrabold)
    let emailLabel          = DUBodyLabel(textAlignment: .center, fontSize: 14, weight: .regular)
    
    var user: User?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor    = DUColors.blue
        configure()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func set(user: User) {
        self.user               = user

        fullNameLabel.textColor = .white
        emailLabel.textColor    = .white

        fullNameLabel.text      = "\(user.firstName ?? "") \(user.lastName ?? "")"
        emailLabel.text         = user.email

        guard let picture       = user.picture else { return }

        NetworkManager.shared.downloadImage(from: picture) { [weak self] image in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.profilreImageView.image = image

            }
        }
    }
    
    private func configure() {
        addSubviews(profilreImageView, fullNameLabel, emailLabel)

        profilreImageView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            profilreImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: -60),
            profilreImageView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            profilreImageView.heightAnchor.constraint(equalToConstant: 100),
            profilreImageView.widthAnchor.constraint(equalTo: profilreImageView.heightAnchor),

            fullNameLabel.topAnchor.constraint(equalTo: profilreImageView.bottomAnchor, constant: 12),
            fullNameLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            fullNameLabel.heightAnchor.constraint(equalToConstant: 22),

            emailLabel.topAnchor.constraint(equalTo: fullNameLabel.bottomAnchor, constant: 8),
            emailLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            emailLabel.heightAnchor.constraint(equalToConstant: 20),

        ])
    }

}
