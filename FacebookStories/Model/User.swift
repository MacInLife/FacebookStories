//
//  User.swift
//  FacebookStories
//
//  Created by Marie-Ange Coco on 11/06/2020.
//  Copyright © 2020 Marie-Ange Coco. All rights reserved.
//

import Foundation
import Firebase

class User {
    var reference : DocumentReference
    var uid : String
    var nickname : String
    var avatarImageUrl : String?
    var coverImageUrl : String?
    
    init(document: DocumentSnapshot){
        reference = document.reference
        uid = document.documentID
        //Tableau : si document vide = pas de data
        let data = document.data() ?? [:]
        nickname = data["nickname"] as? String ?? ""
        avatarImageUrl = data["avatarImageUrl"] as? String ?? ""
        coverImageUrl = data["coverImageUrl"] as? String ?? ""
    }
}
