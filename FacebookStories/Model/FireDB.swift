//
//  FireDB.swift
//  FacebookStories
//
//  Created by Marie-Ange Coco on 01/06/2020.
//  Copyright © 2020 Marie-Ange Coco. All rights reserved.
//

import Foundation
import Firebase
//import FirebaseFirestore

class FireDB {
    let store = Firestore.firestore()
    //A l'inscription crée une collection des Utilisateurs (
    var users : CollectionReference {
        return store.collection("users")
    }
  
    func addUser(_ uid: String, data: [String: Any]) {
        users.document(uid).setData(data)
    }
    func getUser(withUid uid: String, completion: @escaping (String?, User?) -> Void){
        users.document(uid).addSnapshotListener { (document, error) in
            if let error = error {
                completion(error.localizedDescription, nil)
                return
            }
           guard let document = document else {
              completion("Utilisateur non trouvé", nil)
            return
            }
            completion(nil, User(document: document))
        }
    }
      func updateUser(withUid uid: String, data: [String:Any], completion: @escaping (String? ) -> Void){
          users.document(uid).updateData(data) { (error) in
              if let error = error {
                  completion(error.localizedDescription)
                  return
              }
              completion(nil)
          }

      }


}
