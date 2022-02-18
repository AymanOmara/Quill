//
//  HomeTableViewCell.swift
//  Quill
//
//  Created by Ayman Omara on 17/12/2021.
//

import UIKit

class HomeTableViewCell: UITableViewCell {
    var category,title,desc,myStory:String!
    var index:Int!
    @IBOutlet weak var editStory: UIView!
    @IBOutlet weak var storyName: UILabel!
    @IBOutlet weak var storyCategory: UILabel!
    @IBOutlet weak var storyDis: UILabel!
    @IBOutlet weak var commentField: UITextField!
    @IBOutlet weak var submitComment: UIButton!
    @IBOutlet weak var addLike: UIButton!
    @IBOutlet weak var commentsNumber: UILabel!
    var commentClosure:((_ comment:String)->Void)?
    var editClosure:(()->Void)?

    override func awakeFromNib() {
        super.awakeFromNib()
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
        editStory.addGestureRecognizer(tap)
        

    }
    @objc func handleTap(_ sender: UITapGestureRecognizer) {

        editClosure!()
    }

    @IBAction func addComment(_ sender: UIButton) {
        if !commentField.text!.isEmpty{
        commentClosure!(commentField.text ?? "")
        commentField.text = ""
        commentField.resignFirstResponder()
        }
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
}
