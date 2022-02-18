//
//  AddNewStoryViewController.swift
//  Quill
//
//  Created by Ayman Omara on 17/12/2021.
//

import UIKit
import iOSDropDown
class AddNewStoryViewController: UIViewController {
    private let viewModel = AddNewStoryViewModel()
    
    @IBOutlet weak private var storyTitle: UITextField!
    @IBOutlet weak private var storyCategory: DropDown!
    @IBOutlet weak private var storyDescription: UITextField!
    
    @IBOutlet weak var story: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpBinders()
        dropConfiguration()
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
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = true
    }
    func setUpBinders(){
        viewModel.bindMessageIntoView = {[weak self] in
            self?.onFinish()
        }
    }
    func onFinish(){
        if viewModel.message == MessageToUser.postedSuccessfully{
            moveToHome()
            showAlert(message: viewModel.message, title: "Success")
        }else{
            showAlert(message: viewModel.message, title: "Error")
        }
        
    }
    func moveToHome(){
        self.navigationController?.popViewController(animated: true)
    }

    @IBAction func craeteStory(_ sender: Any) {
        let post = PostModel()
        post.category = storyCategory.text
        post.desc = storyDescription.text
        post.title = storyTitle.text
        post.story = story.text
        post.createdBy = viewModel.currentUser
        
        viewModel.insertUser(newPost: post)
    }
}
extension AddNewStoryViewController:UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        storyTitle.resignFirstResponder()
        storyCategory.resignFirstResponder()
        storyDescription.resignFirstResponder()
        story.resignFirstResponder()

        return true
    }
}
