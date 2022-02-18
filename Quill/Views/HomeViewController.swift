//
//  HomeViewController.swift
//  Quill
//
//  Created by Ayman Omara on 17/12/2021.
//

import UIKit
import RealmSwift
class HomeViewController: UIViewController {
    private let localManger = LocalManager.shared
    @IBOutlet private weak var searchBar: UISearchBar!
    @IBOutlet private weak var errorLabel: UILabel!
    private var data:[PostModel] = [PostModel]()
    private var searchedData:[PostModel] = [PostModel]()
    private let viewModel = HomeViewModel()
    private let activityIndicator = UIActivityIndicatorView(style: .large)
    @IBOutlet private weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.keyboardDismissMode = .interactive
        self.title = "Home Screen"
        setUpTableView()
        setUpBinding()
    }
    
    func setUpBinding(){
        viewModel.bindCommentToView = {[weak self]in
            self?.showAlert(message: (self?.viewModel.commentMessage)!, title: "")
        }
        viewModel.bindLoadingToView = {[weak self] in
            guard let self = self else { return }
            if self.viewModel.isloading{
                self.showLoading(activityIndicator: self.activityIndicator)
            }else{
                self.hideLoading(activityIndicator: self.activityIndicator)
            }
        }
        
        viewModel.bindDataToView = {[weak self] in
            guard let self = self else { return  }
            self.data = Array(self.viewModel.data)
            self.errorLabel.text = ""
            self.errorLabel.alpha = 0
            self.tableView.reloadData()
        }
        viewModel.bindErrorToView = {[weak self]in
            self?.errorLabel.text = self?.viewModel.message
            self?.errorLabel.alpha = 1
        }
    }
    func setUpTableView(){
        tableView.tableFooterView = UIView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = false
        let range = Range(uncheckedBounds: (lower: 0, upper: self.tableView.numberOfSections))
        self.tableView.reloadSections(IndexSet(integersIn: range), with: .none)
        viewModel.getPosts()

    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

    }
    @IBAction func goToProfile(_ sender: UIBarButtonItem) {
        let profilevc = self.storyboard?.instantiateViewController(withIdentifier: "ProfileViewController") as! ProfileViewController
        self.navigationController?.pushViewController(profilevc, animated: true)
    }
    
}
extension HomeViewController:UITableViewDelegate ,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searchBar.text!.isEmpty{
            return data.count }
        else{
            return searchedData.count
        }
    }
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70.0
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HomeTableViewCell") as! HomeTableViewCell
        cell.myStory = data[indexPath.row].story
        cell.index = indexPath.row
        cell.editClosure = {[weak self] in
            let editvc = self?.storyboard?.instantiateViewController(withIdentifier: "EditViewController") as! EditViewController
            editvc.titlee = cell.title
            editvc.desc = cell.desc
            editvc.category = cell.category
            editvc.myStory = cell.myStory
            editvc.index = cell.index
            self?.navigationController?.pushViewController(editvc, animated: true)
        }
        if data[indexPath.row].createdBy == localManger.getStatus().currentUser{
            cell.editStory.alpha = 1
        }else{
            cell.editStory.alpha = 0
        }

        if searchBar.text!.isEmpty{
            cell.storyCategory.text = data[indexPath.row].category
            cell.category = data[indexPath.row].category
            cell.storyDis.text = data[indexPath.row].desc
            cell.desc = data[indexPath.row].desc
            cell.storyName.text = data[indexPath.row].title
            cell.title = data[indexPath.row].title
            cell.index = indexPath.row
            cell.commentClosure = {[weak self] comment in
                self?.insertComment(comment: comment, postIndex: indexPath.row)
                self?.tableView.reloadData()
            }
            if  data[indexPath.row].comments.count > 0{
                cell.commentsNumber.alpha = 1
                cell.commentsNumber.text = String(data[indexPath.row].comments.count)+"Comments"
            }else{
                cell.commentsNumber.alpha = 0
            }

        }else{
            cell.storyCategory.text = searchedData[indexPath.row].category
            cell.storyDis.text = searchedData[indexPath.row].desc
            cell.storyName.text = searchedData[indexPath.row].title
            cell.commentClosure = {[weak self] comment in
                self?.insertComment(comment: comment, postIndex: indexPath.row)
                self?.tableView.reloadData()
            }
            if searchedData[indexPath.row].comments.count > 0{
                cell.commentsNumber.alpha = 1
                cell.commentsNumber.text = String(searchedData[indexPath.row].comments.count)+"Comments"
            }else{
                cell.commentsNumber.alpha = 0
            }
        }
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailsVC = self.storyboard?.instantiateViewController(withIdentifier: "DetailsViewController") as! DetailsViewController
        if searchBar.text == ""{
            detailsVC.postModel = self.data[indexPath.row]
            
        }else{
            detailsVC.postModel = self.searchedData[indexPath.row]
        }
        self.navigationController?.pushViewController(detailsVC, animated: true)
    }

    func insertComment(comment:String,postIndex:Int){
        viewModel.postComment(commentText: comment, postIndex: postIndex)
    }
}
extension HomeViewController:UISearchBarDelegate{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchedData = data.filter { $0.category!.lowercased().prefix(searchText.count) == searchText.lowercased() }
        self.tableView.reloadData()
    }
}
extension HomeViewController:UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchBar.resignFirstResponder()
//        storyTitle.resignFirstResponder()
//        storyCategory.resignFirstResponder()
//        storyDescription.resignFirstResponder()
//        story.resignFirstResponder()
//        email.resignFirstResponder()
//        password.resignFirstResponder()
        return true
    }
}

