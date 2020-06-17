//
//  Post.swift
//  FacebookStories
//
//  Created by Marie-Ange Coco on 11/06/2020.
//  Copyright © 2020 Marie-Ange Coco. All rights reserved.
//

import Foundation
import Firebase

class Post {
    var documentReference : DocumentReference
    var documentID : String
    var user : String
    var date : Double
    var likes : [String?]
    var imageUrl: String
    var text : String
    
    init(document: DocumentSnapshot){
        documentReference = document.reference
        documentID = document.documentID
        //Tableau : si document vide = pas de data
        let data = document.data() ?? [:]
        user = data["user"] as? String ?? ""
        date = data["date"] as? Double ?? 0
        likes = data["likes"] as? [String] ?? []
        imageUrl = data["imageUrl"] as? String ?? ""
        text = data["text"] as? String ?? ""
    }
}
