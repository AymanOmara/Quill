//
//  MyPostsViewModel.swift
//  Quill
//
//  Created by Ayman Omara on 20/12/2021.
//

import Foundation
class MyPostsViewModel{
    private let dataManager = DataManager.shared

    var data:[PostModel]!{didSet{bindDataToView()}}
    var bindDataToView:(()->()) = {}
    func getMyPosts(){
        dataManager.getAllPostsByCurrentUser(){
            posts in
            self.data = posts
        }
    }
    
}
