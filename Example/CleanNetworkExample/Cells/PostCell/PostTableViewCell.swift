//
//  PostTableViewCell.swift
//  CleanNetworkExample
//
//  Created by Alperen Ünal on 11.06.2022.
//

import UIKit

class PostTableViewCell: UITableViewCell {
    
    static let reuseIdentifier = "PostTableViewCell"
    
    @IBOutlet private weak var titleLabel: UILabel!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        titleLabel.text = nil
    }
    
    func setCell(with post: Post) {
        titleLabel.text = post.title
    }
}
