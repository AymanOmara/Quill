//
//  HomeViewModel.swift
//  Quill
//
//  Created by Ayman Omara on 17/12/2021.
//

import Foundation
import RealmSwift
class HomeViewModel{
    private let dataManager = DataManager.shared
    var data:Results<PostModel>!{didSet{bindDataToView()}}
    var bindDataToView:(()-> ()) = {}
    var bindLoadingToView:(()-> ()) = {}
    var bindErrorToView:(()-> ()) = {}
    var message:String!{didSet{bindErrorToView()}}
    var isloading:Bool!{didSet{bindLoadingToView()}}
    var commentMessage:String!{didSet{bindCommentToView()}}
    var bindCommentToView:(()-> ()) = {}
    func getPosts(){
        isloading = true
        dataManager.retrivePosts { [weak self] data in
            self?.isloading = false
            if data.isEmpty{
                self?.message = MessageToUser.emptyPosts
                return
            }
            self?.data = data
        }

    }
    func postComment(commentText:String,postIndex:Int){
        let locakManager = LocalManager.shared
        let comment = Comment()
        comment.commentIssuer = locakManager.getStatus().currentUser!
        comment.text = commentText
        dataManager.addComment(comment: comment, postIndex: postIndex){ str in
            
        }
    }
}
