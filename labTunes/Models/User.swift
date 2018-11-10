//
//  User.swift
//  labTunes
//
//  Created by Rodriguez Isaac on 11/9/18.
//  Copyright © 2018 RodriguezIsaac. All rights reserved.
//

import Foundation


class User {
    static let userName = "iOSLab"
    static let password = "verysecurepasword"
    static let session = Session.shareInstance
    static func login (userName: String, password: String) -> Bool{
        if self.userName == userName {
           session.saveSession()
            return true
        }
        return false
    }
    
    static func fetchSongs() throws {
        guard let token = Session.shareInstance.token else {
            throw UserError.notSessionAvailable
        }
        debugPrint(token)
    }
}

enum UserError: Error {
    case notSessionAvailable
}
