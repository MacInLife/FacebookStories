//
//  ProfileHeaderView.swift
//  FacebookStories
//
//  Created by Marie-Ange Coco on 11/06/2020.
//  Copyright © 2020 Marie-Ange Coco. All rights reserved.
//

import UIKit

class ProfileHeaderView: UICollectionReusableView {
    @IBOutlet weak var coverImageView: UIImageView!
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var nicknameLabel: UILabel!
    var user: User?
    var profileViewController: ProfileViewController?
    
    func setUp(user:User, profileViewController: ProfileViewController){
        self.user = user
        self.profileViewController = profileViewController
        nicknameLabel.text = user.nickname
        //Chargement des images via SDWebImage (gestionnaire qui s'occupe des images, charger image [asynchrone], plus faire du cache)
        //ImageLoader().load(stringUrl: user.avatarImageUrl, imageView: avatarImageView)
        //ImageLoader().load(stringUrl: user.coverImageUrl, imageView: coverImageView)
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first
           // let user = user,
           // let uid = FireAuth().uid,
            //uid == user.uid,
            //let profileViewController = profileViewController
            else {
                print("TOUCHE BEGAN STOPPER :")
            return
        }
        switch touch.view {
        case coverImageView:
            print("COVER IMAGE :")
            //Lancer l'action sheet du ProfilViewController
            profileViewController?.presentActionSheet()
            //profileViewController.photoType = .coverImageView
            //profileViewController.chosePhotoSource()
        case avatarImageView:
            print("AVATAR IMAGE :")
            profileViewController?.presentActionSheet()
        case nicknameLabel:
            print("NICKNAME : ")
            //profileViewController.updateNickname()
        default:
            print("DEFAULT : ")
        }
        
        print("TouchView :", touch.view)
    }
}
