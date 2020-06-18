//
//  FireStorage.swift
//  FacebookStories
//
//  Created by Marie-Ange Coco on 18/06/2020.
//  Copyright © 2020 Marie-Ange Coco. All rights reserved.
//

import Foundation
import Firebase

class FireStorage {
    var base = Storage.storage().reference()
    
//    func userCover(uid: String) => storage().reference(){
//        return
//    }
    func sendImage(image: UIImage) {
        guard let jpeg = image.jpegData(compressionQuality: 0.3) else{
            return
        }
        
    }
}
