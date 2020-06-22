//
//  Feed.swift
//  DemoSocialApp
//
//  Created by Manisha Wadekar on 6/20/20.
//  Copyright © 2020 Manisha Wadekar. All rights reserved.
//

import Foundation

// MARK: - Feed
struct FeedElement: Codable {
    let id, createdAt, content: String
    let comments, likes: Int
    let media: [Media]
    let user: [User]
}

// MARK: - Media
struct Media: Codable {
    let mediaId, blogID, createdAt: String
    let image: String
    let title: String
    let url: String
    
    enum CodingKeys: String, CodingKey {
        case mediaId = "id"
        case blogID = "blogId"
        case createdAt, image, title, url
    }
}

// MARK: - User
struct User: Codable {
    let userId, blogID, createdAt, name: String
    let avatar: String
    let lastname, city, designation, about: String
    
    enum CodingKeys: String, CodingKey {
        case userId = "id"
        case blogID = "blogId"
        case createdAt, name, avatar, lastname, city, designation, about
    }
}

typealias Feed = [FeedElement]
