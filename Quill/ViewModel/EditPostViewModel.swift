//
//  EditPostViewModel.swift
//  Quill
//
//  Created by Ayman Omara on 20/12/2021.
//

import Foundation
class EditPostViewModel{
    private let dataManager = DataManager.shared
    var bindResultIntoView:(()-> ()) = {}
    var result:Bool!{didSet{bindResultIntoView()}}

    func saveEditedPost(index:Int,post:PostModel){
        dataManager.editPost(postIndex: index, postModel: post)
        result = true
    }
}
