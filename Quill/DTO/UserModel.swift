//
//  UserModel.swift
//  Quill
//
//  Created by Ayman Omara on 17/12/2021.
//

import Foundation
import RealmSwift
class UserModel:Object{
    @objc dynamic var userName,password,email:String?
    @objc dynamic var age = 0
}
