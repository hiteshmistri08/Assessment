//
//  PostTableViewCell.swift
//  Assessment
//
//  Created by Hitesh on 24/02/21.
//

import UIKit

class PostTableViewCell: UITableViewCell {

    @IBOutlet weak var lblTitle: UILabel!

    static let identifier = "PostTableViewCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    
    func configure(title:String) {
        lblTitle.text = title
    }
}
