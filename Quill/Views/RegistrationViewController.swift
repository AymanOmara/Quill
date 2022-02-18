//
//  RegistrationViewController.swift
//  Quill
//
//  Created by Ayman Omara on 14/12/2021.
//

import UIKit
import MaterialComponents.MaterialTextControls_OutlinedTextFields
class RegistrationViewController: UIViewController {
    
    @IBOutlet weak private var btn: UIButton!
    private let viewModel = RegistrationViewModel()
    @IBOutlet weak private var username: MDCOutlinedTextField!
    @IBOutlet weak private var age: MDCOutlinedTextField!
    @IBOutlet weak private var email: MDCOutlinedTextField!
    @IBOutlet weak private var password: MDCOutlinedTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpLabelsForTextField()
        setUpBinders()
        
    }
    func setUpBinders(){
        viewModel.bindMessageIntoView = {[weak self] in
            self?.onFinish()
        }
    }
    func onFinish(){
        if viewModel.message == MessageToUser.success{
            self.showToast(message: viewModel.message, font: UIFont.systemFont(ofSize: 14))

            DispatchQueue.main.asyncAfter(deadline: .now() + .microseconds(300000)) {
                    self.moveToLogIn()
            }
        }else{
            showAlert(message: viewModel.message, title: "Error")
        }
        
    }
    func moveToLogIn(){

        self.dismiss(animated: true, completion: nil)
    }
    //username
    @IBAction func emailEndEditing(_ sender: MDCOutlinedTextField) {
        if username.text!.isEmpty{
            MDCOutlinedTextField.setError(textField: username, message: MessageToUser.empty)
            hidebtn()
        }else if !viewModel.isValidName(text: username.text!){
            MDCOutlinedTextField.setError(textField: username, message: MessageToUser.inValidFormate)
            hidebtn()
        }else{
            MDCOutlinedTextField.setToBeValid(textField: username)
            showSignUpBtn()
        }
    }
    
    @IBAction func ageDidEnd(_ sender: MDCOutlinedTextField) {
        if age.text!.isEmpty{
            MDCOutlinedTextField.setError(textField: age, message: MessageToUser.empty)
            hidebtn()
        }else if !viewModel.checkifNumber(text: age.text!){
            MDCOutlinedTextField.setError(textField: age, message: MessageToUser.inValidFormate)
            hidebtn()
        }else{
            MDCOutlinedTextField.setToBeValid(textField: age)
            showSignUpBtn()
        }
    }
    
    @IBAction func mailDidEnd(_ sender: MDCOutlinedTextField) {
        if email.text!.isEmpty{
            MDCOutlinedTextField.setError(textField: email, message: MessageToUser.empty)
            hidebtn()
        }else if !viewModel.isValidEmail(text: email.text!){
            MDCOutlinedTextField.setError(textField: email, message: MessageToUser.emailFormate)
            hidebtn()
        }else{
            MDCOutlinedTextField.setToBeValid(textField: email)
            showSignUpBtn()
        }
    }
    
    @IBAction func passwordDidEnd(_ sender: MDCOutlinedTextField) {
        if password.text!.isEmpty{
            MDCOutlinedTextField.setError(textField: password, message: MessageToUser.empty)
            hidebtn()
        }else if !viewModel.isValidPassword(testStr:password.text!){
            MDCOutlinedTextField.setError(textField: password, message: MessageToUser.invalidPassword)
            hidebtn()
        }else{
            MDCOutlinedTextField.setToBeValid(textField: password)
            showSignUpBtn()
        }

    }
    func showSignUpBtn(){
        if viewModel.isValidEmail(text: email.text!)  && viewModel.isValidName(text: username.text!) && viewModel.isValidPassword(testStr: password.text) && viewModel.checkifNumber(text: age.text!){
                   btn.alpha = 1
                   btn.isUserInteractionEnabled = true
       }
    }
    
    func hidebtn(){
        btn.alpha = 0.6
        btn.isUserInteractionEnabled = false
    }

    func setUpLabelsForTextField(){
        username.label.text = "User Name"
        age.label.text = "Age"
        email.label.text = "Email"
        password.label.text = "Password"
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = false
    }
    
    @IBAction func signUp(_ sender: Any) {
        let user = UserModel()
        user.email = email.text!
        user.password = password.text!
        user.age = Int(age.text!)!
        user.userName = username.text
        viewModel.insertUser(user: user)
    }
}
extension RegistrationViewController:UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        username.resignFirstResponder()
        age.resignFirstResponder()
        email.resignFirstResponder()
        password.resignFirstResponder()
        return true
    }
}
