//
//  PostsVC.swift
//  Assessment
//
//  Created by Hitesh on 24/02/21.
//

import UIKit

class PostsVC: UIViewController {

    // MARK:- IBOutlet
    @IBOutlet weak var tableView: UITableView!
    
    static let storyBoardIdentifier = "PostsVC"
    let postViewModel = PostViewModel()
    
    
    // MARK:- LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        fetchPosts()
        
    }
    
    func setupTableView() {
        tableView.estimatedRowHeight = 50
        tableView.rowHeight = UITableView.automaticDimension

        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func fetchPosts() {
        postViewModel.fetchPosts { [weak self] (error) in
            if error != nil {
                self?.showAlert(title: "Error!", message: error?.localizedDescription ?? "", completion: nil)
            }
            self?.tableView.reloadData()
        }
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        
        if segue.identifier == PostDetailVC.storyBoardIdentifier ,let vc = segue.destination as? PostDetailVC, let detail = sender as? Post {
            vc.setDetail(detail)
        }
    }
    

}
