//
//  ProfileViewController.swift
//  Quill
//
//  Created by Ayman Omara on 18/12/2021.
//

import UIKit

class ProfileViewController: UIViewController {
    private let options = ["change Password","about us","Sign Out"]
    @IBOutlet weak private var tableView: UITableView!
    
    private let localManager = LocalManager.shared
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = true
    }
}
extension ProfileViewController:UITableViewDelegate ,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return options.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProfileTableViewCell") as! ProfileTableViewCell
        cell.label.text = options[indexPath.row]

        if indexPath.row == 2{
            cell.label.textColor = .red
        }
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 2{
            localManager.setStatus(currentUser: "", isRememberMe: false)
            moveToWelcome()
        }
    }
    func moveToWelcome(){
        let welcomeView = self.storyboard?.instantiateViewController(withIdentifier: "WelcomeViewController") as! WelcomeViewController
        self.navigationController?.pushViewController(welcomeView, animated: true)
    }
}
