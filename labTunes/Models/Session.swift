//
//  Session.swift
//  labTunes
//
//  Created by Rodriguez Isaac on 11/9/18.
//  Copyright © 2018 RodriguezIsaac. All rights reserved.
//

import Foundation
class Session: NSObject {
    var token: String?
    static let shareInstance = Session()
    
    override private init() {
        super.init()
    }
    
    func saveSession() {
        token = "1234567890"
    }
}

// el objecto session
// solo una instancia del obejto un singleton
// se crea la constante estatica
// se sobre escribe el inicializador para que se llame solo en la clase 
