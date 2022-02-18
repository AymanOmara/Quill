//
//  ViewsExtention.swift
//  Quill
//
//  Created by Ayman Omara on 14/12/2021.
//

import Foundation
import MaterialComponents.MaterialTextControls_OutlinedTextFields
extension MDCOutlinedTextField{
  static func setError(textField:MDCOutlinedTextField,message:String){
        textField.setOutlineColor(.red, for: .normal)
        textField.setOutlineColor(.red, for: .editing)
        textField.leadingAssistiveLabel.text = message

    }
    static func removeError(textField:MDCOutlinedTextField){

        textField.setOutlineColor(.black, for: .normal)
        textField.setOutlineColor(.black, for: .editing)
        textField.leadingAssistiveLabel.text = nil

    }
    static func setToBeValid(textField:MDCOutlinedTextField){
        textField.setOutlineColor(.green, for: .normal)
        textField.setOutlineColor(.green, for: .editing)
        textField.leadingAssistiveLabel.text = nil

    }
}
extension UIViewController{
    func showAlert(message:String,title:String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let OK = UIAlertAction(title: "OK", style: .default, handler: nil)
        
        alert.addAction(OK)
        self.present(alert, animated: true, completion: nil)
    }
    func setRootViewController(viewController:UIViewController){
        UIApplication.shared.windows.first?.rootViewController = viewController
        UIApplication.shared.windows.first?.makeKeyAndVisible()
    }
    func showLoading(activityIndicator:UIActivityIndicatorView){
        activityIndicator.hidesWhenStopped = true
        activityIndicator.center = self.view.center
        self.view.addSubview(activityIndicator)
        activityIndicator.startAnimating()
        
    }
    func hideLoading(activityIndicator:UIActivityIndicatorView){
        activityIndicator.stopAnimating()
    }
    func showToast(message : String, font: UIFont) {
        
        let toastLabel = UILabel(frame: CGRect(x: self.view.frame.size.width/2 - 120, y: self.view.frame.size.height-100, width: 250, height: 35))
        toastLabel.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        toastLabel.textColor = UIColor.white
        toastLabel.font = font
        toastLabel.textAlignment = .center;
        toastLabel.text = message
        toastLabel.alpha = 1.0
        toastLabel.layer.cornerRadius = 10;
        toastLabel.clipsToBounds  =  true
        self.view.addSubview(toastLabel)
        UIView.animate(withDuration: 4.0, delay: 0.1, options: .curveEaseOut, animations: {
            toastLabel.alpha = 0.0
        }, completion: {(isCompleted) in
            toastLabel.removeFromSuperview()
        })
    }
}
