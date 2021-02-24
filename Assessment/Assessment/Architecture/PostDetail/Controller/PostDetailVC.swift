//
//  PostDetailVC.swift
//  Assessment
//
//  Created by Hitesh on 24/02/21.
//

import UIKit

class PostDetailVC: UIViewController {
    // MARK:- IBOutlet
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblDescription: UILabel!

    static let storyBoardIdentifier = "PostDetailVC"
    var viewModel: PostDetailViewModel?
    
    
    // MARK:- LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    func setDetail(_ post:Post) {
        viewModel = PostDetailViewModel(post)
    }
    func setupUI() {
        lblTitle.text = viewModel?.postDetail.title
        lblDescription.text = viewModel?.postDetail.body
    }

}
