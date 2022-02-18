//
//  MyPostsViewController.swift
//  Quill
//
//  Created by Ayman Omara on 20/12/2021.
//

import UIKit

class MyPostsViewController: UIViewController {
    let viewModel = MyPostsViewModel()
    var data = [PostModel]()
    @IBOutlet weak private var tabelView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.getMyPosts()
        viewModel.bindDataToView = {
            self.data = self.viewModel.data
            self.tabelView.reloadData()
        }

    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = false
        viewModel.getMyPosts()
    }

}
extension MyPostsViewController:UITableViewDelegate ,UITableViewDataSource{
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyPostsTableViewCell") as! MyPostsTableViewCell
        cell.storyCategory.text = data[indexPath.row].category
        cell.storyDescription.text = data[indexPath.row].desc
        cell.storyTitle.text = data[indexPath.row].title
        return cell
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        data.count
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 260
    }
}
