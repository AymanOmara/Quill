//
//  DataManager.swift
//  Quill
//
//  Created by Ayman Omara on 17/12/2021.
//

import Foundation
import RealmSwift

class DataManager{
    private lazy var realm:Realm = {return try! Realm()}()
    static let shared = DataManager()
    private let localManager = LocalManager.shared
    
    func addNewUser(newUser:UserModel,complition:@escaping(String)->Void){
        do{ try realm.write {
            realm.add(newUser)
        }}catch{
            complition(error.localizedDescription)
            return
        }
        complition(MessageToUser.success)

    }
    func retriveUsers(complition:@escaping(Results<UserModel>)->Void){

        complition(realm.objects(UserModel.self))
    }
    func getAllPostsByCurrentUser(complition:@escaping([PostModel])->Void){
        let array = Array(realm.objects(PostModel.self))
        
        var tempArray = [PostModel]()
        for i in array{
            if i.createdBy == localManager.getStatus().currentUser{
                tempArray.append(i)
            }
        }
        complition(tempArray)

    }
    
    func addNewPost(newPost:PostModel,complition:@escaping(String)->Void){
        do{ try realm.write {
            realm.add(newPost)
        }}catch{

            complition(error.localizedDescription)
            return
        }
        complition(MessageToUser.postedSuccessfully)
    }
    func addComment(comment:Comment,postIndex:Int,complition:@escaping(String)->Void){
        let posts = realm.objects(PostModel.self)
        do{ try realm.write {
           posts[postIndex].comments.append(comment)
        }
            }
        catch{
            complition(error.localizedDescription)
            return
        }
        complition("comment Posted Successfully")
    }
    func editPost(postIndex:Int,postModel:PostModel){
        let posts = realm.objects(PostModel.self)
        do{ try! realm.write {
            posts[postIndex].title = postModel.title
            posts[postIndex].category = postModel.category
            posts[postIndex].desc = postModel.desc
            posts[postIndex].story = postModel.story
        }
    }

}
    func retrivePosts(complition:@escaping(Results<PostModel>)->Void){
        complition(realm.objects(PostModel.self))
    }
    private init(){
    }
}
