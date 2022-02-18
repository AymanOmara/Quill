//
//  LocalManager.swift
//  Quill
//
//  Created by Ayman Omara on 14/12/2021.
//

import Foundation
class LocalManager{
    
    static let shared = LocalManager()
    private var userDefaults:UserDefaults
    
    func setStatus(currentUser:String,isRememberMe:Bool){
        
        userDefaults.set(currentUser, forKey: Keys.currentUser)
        userDefaults.set(isRememberMe, forKey: Keys.isRememberMe)
    }
    func getStatus() -> (currentUser:String?,isRememberMe:Bool?) {
        let currentUser = userDefaults.value(forKey: Keys.currentUser) as? String ?? ""
        let isRememberMe = userDefaults.value(forKey: Keys.isRememberMe) as? Bool ?? false
        return (currentUser:currentUser,isRememberMe:isRememberMe)
    }
    private init(){
        userDefaults = UserDefaults.standard
    }
}
struct Keys {
    static let currentUser = "currentUser"
    static let isRememberMe = "isRememberMe"
}
