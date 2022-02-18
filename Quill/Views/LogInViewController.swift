//
//  ViewController.swift
//  Quill
//
//  Created by Ayman Omara on 14/12/2021.
//

import UIKit
import MaterialComponents.MaterialTextControls_OutlinedTextFields
import M13Checkbox
class LogInViewController: UIViewController {
    @IBOutlet weak var topView: UIView!
    
    @IBOutlet weak private var password: MDCOutlinedTextField!
    @IBOutlet weak private var email: MDCOutlinedTextField!
    @IBOutlet weak private var mainView: UIView!
    @IBOutlet weak private var isRememberMe: M13Checkbox!
    private var viewMdel = LogInViewModel()
    private var homeViewController:TabBar!
    private let activityIndicator = UIActivityIndicatorView(style: .large)
   

    override func viewDidLoad() {
        super.viewDidLoad()
        homeViewController = self.storyboard?.instantiateViewController(withIdentifier: "TabBar") as! TabBar
        
        setUpTextFieldHeader()
        setUpBinding()
        handelView()
        
    }
    @IBAction func cancel(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func goToRegister(_ sender: UIButton) {
       let registerVC = self.storyboard?.instantiateViewController(withIdentifier: "RegistrationViewController") as! RegistrationViewController
        let navController = UINavigationController(rootViewController:registerVC)
        self.present(navController, animated: true, completion: nil)

    }
    func setUpBinding(){
        viewMdel.bindResultIntoView = {[weak self] in
            guard let self = self else{return}
            if self.viewMdel.result{
                let navController = UINavigationController(rootViewController: self.homeViewController)
                if self.isRememberMe.isSelected{
                UIApplication.shared.windows.first?.rootViewController = self.homeViewController
                UIApplication.shared.windows.first?.makeKeyAndVisible()
                    
                }

                navController.isNavigationBarHidden = true
                navController.modalPresentationStyle = .fullScreen
                self.present(navController, animated: true, completion: nil)

                return
            }
            
            self.showAlert(message: self.viewMdel.message ?? "", title: "Error")
        }
        viewMdel.bindLoadingToView = {[weak self] in
            guard let self = self else{return}
            if self.viewMdel.isloading{
                self.showLoading(activityIndicator: self.activityIndicator)
            }else{
                self.hideLoading(activityIndicator: self.activityIndicator)
            }
        }
        
    }

    @objc func clickAction(sender : UITapGestureRecognizer) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    func handelView(){
        topView.backgroundColor = UIColor(white: 1, alpha: 0.000001)
        self.view.backgroundColor = UIColor(white: 1, alpha: 0.000001)
        
        
        let gesture = UITapGestureRecognizer(target: self, action:  #selector(clickAction(sender:)))
        topView.addGestureRecognizer(gesture)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        viewMdel.getUsers()
    }
    
    func setUpTextFieldHeader(){
        email.label.text = "Email"
        password.label.text = "Password"
    }
    
    @IBAction func login(_ sender: UIButton) {
        if isRememberMe.checkState == .checked{
            viewMdel.checkIFUserExists(email: email.text!, password: password.text!, rememberMe: true)
        }else{
            viewMdel.checkIFUserExists(email: email.text!, password: password.text!, rememberMe: false)
        }
        
    }

}
extension LogInViewController:UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        email.resignFirstResponder()
        password.resignFirstResponder()
        return true
    }
}
