//
//  AddNewStoryViewModel.swift
//  Quill
//
//  Created by Ayman Omara on 17/12/2021.
//

import Foundation
import RealmSwift
class AddNewStoryViewModel{
    private let dataManager = DataManager.shared
    let currentUser = LocalManager.shared.getStatus().currentUser

    var bindMessageIntoView:(()-> ()) = {}
    var message:String!{didSet{bindMessageIntoView()}}
    
    func insertUser(newPost:PostModel){
        dataManager.addNewPost(newPost: newPost) {[weak self] message in
            self?.message = message
            }
        }
}
