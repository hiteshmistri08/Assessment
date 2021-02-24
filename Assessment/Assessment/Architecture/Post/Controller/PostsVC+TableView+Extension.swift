//
//  PostsVC+TableView+Extension.swift
//  Assessment
//
//  Created by Hitesh on 24/02/21.
//

import UIKit
// MARK :- UITableViewDataSource
extension PostsVC:UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return postViewModel.posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PostTableViewCell.identifier) as! PostTableViewCell
        cell.configure(title: postViewModel.posts[indexPath.row].title)
        return cell
    }
}

// MARK:- UITableViewDelegate
extension PostsVC : UITableViewDelegate {
    
}
