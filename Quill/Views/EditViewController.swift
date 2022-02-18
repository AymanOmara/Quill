//
//  EditViewController.swift
//  Quill
//
//  Created by Ayman Omara on 20/12/2021.
//

import UIKit
import iOSDropDown
class EditViewController: UIViewController {
    var category,titlee,desc,myStory:String!
    var index:Int!
    var post = PostModel()
    private let viewModel = EditPostViewModel()
    @IBOutlet weak private var story: UITextField!
    @IBOutlet weak private var storyDesc: UITextField!
    @IBOutlet weak private var storyCategory: DropDown!
    @IBOutlet weak private var storyTitle: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        dropConfiguration()
        viewModel.bindResultIntoView = {
            self.navigationController?.popViewController(animated: true)
        }
        story.text = myStory
        storyCategory.text = category
        storyDesc.text = desc
        storyTitle.text = titlee
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = true
    }
    
    @IBAction func cancel(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    func dropConfiguration() {
        storyCategory.optionArray = ["---","Comedy","Action","Drama","Fantasy","Horror","Mystery","Romance","Thriller","Western"]
        storyCategory.text = "---"
        storyCategory.selectedIndex = 0
        storyCategory.listHeight = 240
        storyCategory.isSearchEnable = true
        storyCategory.rowBackgroundColor = .white
        storyCategory.selectedRowColor = .white
        storyCategory.checkMarkEnabled = true
        
    }
    
    @IBAction func submit(_ sender: Any) {
        post.category = self.storyCategory.text
        post.title = self.storyTitle.text
        post.desc = self.storyDesc.text
        post.story = story.text
        
        viewModel.saveEditedPost(index: index, post: post)

        
    }

}
