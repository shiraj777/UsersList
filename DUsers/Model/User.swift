//
//  User.swift
//  DUsers
//
//  Created by Shira Janach on 19/05/2021.
//

import Foundation

struct UsersData: Codable {
    var data: [User]
}

struct User: Codable {
    let id: String
    var lastName: String?
    var firstName: String?
    var email: String?
    var title: String?
    var picture: String?
}
