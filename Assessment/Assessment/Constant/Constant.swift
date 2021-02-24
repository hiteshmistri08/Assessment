//
//  Constant.swift
//  Assessment
//
//  Created by Hitesh on 23/02/21.
//

import Foundation


let BaseURL = "https://jsonplaceholder.typicode.com/"

struct ServerEndPoint {
    private init() {}
    static let posts = BaseURL + "posts"
}
