//
//  PostManager.swift
//  Assessment
//
//  Created by Hitesh on 24/02/21.
//

import Foundation
import CoreData

struct PostManager {
    private let postDataRepository = PostDataRepository()
    func create(_ record:Post) -> Bool {
        return postDataRepository.create(record)
    }
    func getAll() -> [Post]? {
        return postDataRepository.getAll()
    }
}
