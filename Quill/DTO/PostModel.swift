//
//  PostModel.swift
//  Quill
//
//  Created by Ayman Omara on 18/12/2021.
//

import Foundation
import RealmSwift
class PostModel:Object{
    @objc dynamic var category,createdBy,desc,title,story:String?
    @objc dynamic var likeNumber = 0
     var comments:List<Comment> = List<Comment>()
}
class Comment:Object{
    @objc dynamic var text,commentIssuer:String?
}
