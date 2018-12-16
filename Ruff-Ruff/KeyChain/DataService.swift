//
//  DataService.swift
//  Ruff-Ruff
//
//  Created by Nikhil on 6/9/18.
//  Copyright © 2018 ruffRuff. All rights reserved.
//

import Foundation
import Firebase
import FirebaseDatabase
import KeychainSwift

let DB_BASE = Database.database().reference()

class DataSerivce{
    private var _keyChain = KeychainSwift()
    private var _refDatabase = DB_BASE
    
    var keyChain: KeychainSwift{
        get {
            return _keyChain
        } set{
            _keyChain = newValue
        }
    }
}

