//
//  LogInViewModel.swift
//  Quill
//
//  Created by Ayman Omara on 14/12/2021.
//

import Foundation
import RealmSwift
class LogInViewModel{
    private let localManager = LocalManager.shared
    private let dataManager = DataManager.shared
    var bindResultIntoView:(()-> ()) = {}
    var result:Bool!{didSet{bindResultIntoView()}}
    var data:Results<UserModel>!
    var isloading:Bool!{didSet{bindLoadingToView()}}
    var bindLoadingToView:(()-> ()) = {}
    var bindErrorToView:(()-> ()) = {}
    var message:String!{didSet{bindErrorToView()}}
    
    
    func getUsers(){
        dataManager.retriveUsers { [weak self] users in
            self?.data = users
            print(users)
        }
//        dataManager.getAllPostsByCurrentUser { posts in
//
//        }
    }

    func checkIFUserExists(email:String,password:String,rememberMe:Bool){
        if email.isEmpty || password.isEmpty{
            message = MessageToUser.emptyMailOrPassword
            result = false
            return
        }
        for i in data {
            if email.caseInsensitiveCompare(i.email ?? "") == .orderedSame && password == i.password{
                saveUserEmailAndState(currentUser: email, isRememberMe: rememberMe)
                message = MessageToUser.logInSuccess
                
                result = true
                
                return
            }
        }
        message = MessageToUser.logInFaild
        result = false

        
    }
    func saveUserEmailAndState(currentUser:String,isRememberMe:Bool){
        localManager.setStatus(currentUser: currentUser, isRememberMe: isRememberMe)
    }
}
