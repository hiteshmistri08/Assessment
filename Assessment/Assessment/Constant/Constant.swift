//
//  Constant.swift
//  Assessment
//
//  Created by Hitesh on 23/02/21.
//

import UIKit

struct StoryBorads {
    private init() {}
    static let main = UIStoryboard(name: "Main", bundle:nil)
}

// Server
let BaseURL = "https://jsonplaceholder.typicode.com/"

struct ServerEndPoint {
    private init() {}
    static let posts = BaseURL + "posts"
}
