//
//  Post.swift
//  Assessment
//
//  Created by Hitesh on 24/02/21.
//

import Foundation

struct Post: Codable {
    let userID:Int
    let id: Int
    let title : String
    let body: String

    enum CodingKeys: String, CodingKey {
        case userID = "userId"
        case id, title, body
    }
}

typealias Posts = [Post]
