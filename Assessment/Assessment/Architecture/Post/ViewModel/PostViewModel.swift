//
//  PostViewModel.swift
//  Assessment
//
//  Created by Hitesh on 24/02/21.
//

import Foundation

class PostViewModel {
    var posts = [Post]()
    let postManager:PostManager
    
    init(_ postManager:PostManager = PostManager()) {
        self.postManager = postManager
    }
    
    func fetchPosts(completion:@escaping(Error?) -> Void) {
        guard let url = URL(string: ServerEndPoint.posts) else { return }
        debugPrint("Url :- ",url.absoluteURL)
        Webservice.get(url: url) { [weak self] (data, urlResponse, error) in
            if let data = data, error == nil {
                do {
                    let response = try JSONDecoder().newJSONDecoder().decode(Posts.self, from: data)
                    self?.posts += response
                    self?.syncPosts()
                } catch {
                    debugPrint("\(url) Error is:- ",error.localizedDescription)
                }
            }
            DispatchQueue.main.async {
                completion(error)
            }
        }
    }
    
    private func syncPosts() {
       let isSync = postManager.syncPosts(self.posts)
        debugPrint("database sync :- ",isSync)
    }
    
    
}
