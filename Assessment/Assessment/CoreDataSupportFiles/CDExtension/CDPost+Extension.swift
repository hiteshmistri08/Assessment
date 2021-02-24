//
//  CDPost+Extension.swift
//  Assessment
//
//  Created by Hitesh on 24/02/21.
//

import Foundation
import CoreData

extension CDPost {
    func convertToPost() -> Post {
        let post = Post(userID: Int(self.userID) , id: Int(self.id), title: self.title ?? "", body: self.body ?? "")
        return post
    }
}
