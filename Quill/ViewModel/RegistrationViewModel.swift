//
//  RegistrationViewModel.swift
//  Quill
//
//  Created by Ayman Omara on 14/12/2021.
//

import Foundation
class RegistrationViewModel{
    private let dataManager = DataManager.shared
    var oldUsers:[UserModel] = [UserModel]()
    var bindMessageIntoView:(()-> ()) = {}
    var message:String!{didSet{bindMessageIntoView()}}
    func isValidPassword(testStr: String?) -> Bool {
        guard testStr != nil else { return false }
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", "(?=.*[^A-Za-z0-9])(?=.*[0-9])(?=.*[a-z]).{8,}")
        return passwordTest.evaluate(with: testStr)
    }
    
    func isValidEmail(text:String) -> Bool{
       let range = NSRange(location: 0, length: text.utf16.count)
       let regex = try! NSRegularExpression(pattern: "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,6}")
       if(regex.firstMatch(in: text, options: [], range: range) != nil){
           return true
       }else{
           return false
       }
   }
     func checkifNumber(text:String) -> Bool{
        let range = NSRange(location: 0, length: text.utf16.count)
        let regex = try! NSRegularExpression(pattern: "-?\\d+(\\.\\d+)?")
        if(regex.firstMatch(in: text, options: [], range: range) != nil){
            return true
        }else{
            return false
        }
    }
    
    func isValidName(text:String)-> Bool{
        let range = NSRange(location: 0, length: text.utf16.count)
        let regex = try! NSRegularExpression(pattern: "[0-9]+")
        if(regex.firstMatch(in: text, options: [], range: range) != nil){
            return false
        }else{
            return true
        }
    }
    func isEmailUsedBefore(email:String)->Bool{
        dataManager.retriveUsers { [weak self] users in
            self?.oldUsers = Array(users)
            }
        for i in oldUsers{
            if email.caseInsensitiveCompare(i.email ?? "") == .orderedSame{
                return true
            }
        }
            return false
    }
    func insertUser(user:UserModel){
        dataManager.addNewUser(newUser: user) {[weak self] message in
            self?.message = message
        }
    }
    
    
}

