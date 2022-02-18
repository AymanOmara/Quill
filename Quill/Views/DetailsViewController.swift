//
//  DetailsViewController.swift
//  Quill
//
//  Created by Ayman Omara on 19/12/2021.
//

import UIKit

class DetailsViewController: UIViewController {
    @IBOutlet weak private var tableView: UITableView!
    
    @IBOutlet weak private var storyName: UILabel!
    var postModel:PostModel!
    override func viewDidLoad() {
        super.viewDidLoad()
        storyName.text = postModel.title
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 70
        

    }
    
    @IBAction func done(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = true
    }
    

}
extension DetailsViewController: UITableViewDelegate ,UITableViewDataSource{
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DetailsTableViewCell") as! DetailsTableViewCell
        cell.issureEmail.text = postModel.comments[indexPath.row].commentIssuer
        cell.commentText.text = postModel.comments[indexPath.row].text
        return cell
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return postModel.comments.count
    }
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 90
//    }
}
