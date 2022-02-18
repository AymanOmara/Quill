//
//  WelcomeViewController.swift
//  Quill
//
//  Created by Ayman Omara on 19/12/2021.
//

import UIKit

class WelcomeViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    

    @IBAction func goToLogIn(_ sender: UIButton) {
        let loginView = self.storyboard?.instantiateViewController(withIdentifier: "LogInViewController") as! LogInViewController
        let navVC = UINavigationController(rootViewController:loginView)
        navVC.isNavigationBarHidden = true
        self.present(navVC, animated: true, completion:nil)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = true
        self.tabBarController?.tabBar.isHidden = true
    }
}
