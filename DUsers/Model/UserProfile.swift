//
//  UserProfile.swift
//  DUsers
//
//  Created by Shira Janach on 19/05/2021.
//

import Foundation

struct PostData: Codable {
    var data: [Post]
}

struct Post: Codable {
    var owner: User
    let id: String
    var image: String?
    let publishDate: String
    var text: String?
    var tags: [String]?
    var link: String?
    var likes: Int?
    
}
