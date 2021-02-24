//
//  PostDataRepository.swift
//  Assessment
//
//  Created by Hitesh on 24/02/21.
//

import Foundation
import CoreData

protocol PostRepository:BaseRepository {
    
}

struct PostDataRepository:PostRepository {
    typealias T = Post

    func create(_ record: Post) -> Bool {
        let cdPost = CDPost(context: PersistentStorage.shared.context)
        cdPost.id = Int16(record.id)
        cdPost.userID = Int16(record.userID)
        cdPost.title = record.title
        cdPost.body = record.body
        PersistentStorage.shared.saveContext()
        return true
    }
    
    func getAll() -> [Post]? {
        let result = PersistentStorage.shared.fetchManagedObject(CDPost.self)
        guard result != nil && result?.count != 0 else { return nil }
        return result!.map{$0.convertToPost()}
    }
    
    func get(by id: Int) -> Post? {
        return fetchPost(by: id)?.convertToPost()
    }
    
    func update(_ record: Post) -> Bool {
        guard let cdPost = fetchPost(by: record.id) else { return false }
        cdPost.title = record.title
        cdPost.body = record.body
        PersistentStorage.shared.saveContext()
        return true
    }
    
    func delete(_ id: Int) -> Bool {
        guard let cdPost = fetchPost(by: id) else { return false }
        PersistentStorage.shared.context.delete(cdPost)
        PersistentStorage.shared.saveContext()
        return true
    }
    
    
    private func fetchPost(by id:Int) -> CDPost? {
        let request : NSFetchRequest<CDPost> = CDPost.fetchRequest()
        let predicate = NSPredicate(format: "id=%@", Int16(id) as CVarArg)
        request.predicate = predicate
        do {
            return try PersistentStorage.shared.context.fetch(request).first
        } catch {
            debugPrint("error fetchPost :- ",error.localizedDescription)
        }
        return nil
    }
}
