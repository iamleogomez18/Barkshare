//
//  PetImages.swift
//  Ruff-Ruff
//
//  Created by Likhon Gomes on 6/11/18.
//  Copyright © 2018 ruffRuff. All rights reserved.
//

import Foundation
import FirebaseDatabase

struct PetImages {
    let key:String!
    let url:String!
    
    let itemReference:FIRDatabaseReference?
    
    init(key:String, url:String) {
        self.key=key
        self.url=url
        self.itemReference = nil
    }
    
    init(snapshot:FIRDataSnapshot) {
        key = snapshot.key
        itemReference = snapshot.ref
        
        let snapshotValue = snapshot.value as? NSDictionary
        if let imageUrl = snapshotValue?["url"]as? String{
            url = imageUrl
        }else{
            url = ""
        }
    }
}
