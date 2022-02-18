//
//  MyPostsTableViewCell.swift
//  Quill
//
//  Created by Ayman Omara on 20/12/2021.
//

import UIKit

class MyPostsTableViewCell: UITableViewCell {

    @IBOutlet weak var storyDescription: UILabel!
    @IBOutlet weak var storyCategory: UILabel!
    @IBOutlet weak var storyTitle: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
