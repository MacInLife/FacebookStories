//
//  ProfileViewController.swift
//  FacebookStories
//
//  Created by Marie-Ange Coco on 11/06/2020.
//  Copyright © 2020 Marie-Ange Coco. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {
    
    var postImage : UIImage?
    var user: User?
    var headerView: ProfileHeaderView?
    var photoType: PhotoType?
     enum PhotoType{
         case coverImageView , avatarImageView
        case postImage
     }
     
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let uid = FireAuth().currentId else {
            dismiss(animated: true, completion: nil)
            return
        }
        FireDB().getUser(withUid: uid) { (error, user) in
            if let error = error {
                self.presentAlert(title: "error", message: error)
                return
            }
            guard let user = user else {
                self.dismiss(animated: true, completion: nil)
                return
            }
            self.user = user
            print("Utilisateur :", user.nickname)
            self.collectionView.reloadData()
        }
        
    }
    

        // Do any additional setup after loading the view.
    
    
    @IBAction func writeBtnDidPressed(_ sender: Any) {
        presentActionSheet()
    }
    
    func updateNickname() {
        guard let uid = FireAuth().currentId else {
        dismiss(animated: true, completion: nil)
        return
        }
        let alertVC = UIAlertController(title: "Modifier votre pseudo", message: nil, preferredStyle: .alert)
        alertVC.addTextField { (textField) in
            textField.placeholder = "Tapez ici votre nouveau pseudo"
        }
        alertVC.addAction(UIAlertAction(title: "Annuler", style: .cancel, handler: nil))
        alertVC.addAction(UIAlertAction(title: "Modifier", style: .default, handler: { (action) in
            if let nickname = alertVC.textFields?.first?.text {
                FireDB().updateUser(withUid: uid, data: ["nickname": nickname]) { (error) in
                    if let error = error {
                        self.presentAlert(title: "Erreur !", message: error)
                        return
                    }
                    self.headerView?.nicknameLabel.text = nickname
                }
            }
        }))
        present(alertVC, animated: true, completion: nil)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
extension ProfileViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        // Quitter la vue modale de l’Image Picker
        dismiss(animated: true, completion: nil)
        
        // Récupérer l’image fournie par l’UIImagePickerController
             guard let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else {
                 return
             }
         print("IMAGE", image)
            guard let uid = FireAuth().currentId else {
                     dismiss(animated: true, completion: nil)
                     return
                 }
        // Transmettre l’image à une propriété de ProfileViewController (postImage)
        // postImage pourra ainsi transmettre l’image à la méthode prepare(for segue)
        // Pour rappel, c’est prepare(for segue) qui devra transmettre l’image au contrôleur suivant
        self.postImage = image
        let ref = FireStorage().profileImageRef(uid: uid)
        FireStorage().sendImage(ref:  ref , image: image) { (error, url) in
                   if let error = error {
                       self.presentAlert(title: "error", message: "error")
                       return
                   }
                   guard let photoType = self.photoType else{
                       return
                   }
                    var key: String
                   switch photoType {
                   case .coverImageView:
                       key = "coverImageUrl"
                   case .avatarImageView:
                       key = "avatarImageUrl"
                   case .postImage:
                     key = "postImage"
            }
                    print("KEY: ", key)
                  // mettre a jour propriété url image
                   FireDB().updateUser(withUid: uid, data: [key: url], completion: { (error) in
                       if let error = error {
                           self.presentAlert(title: "error", message: "error ")
                           return
                       }
                   })
        }
        // Lancer la segue vers le contrôleur suivant
        // Après cela, il restera à écrire l’override de la méthode prepare(for segue)
        // performSegue(withIdentifier: "segueToWrite", sender: nil)
        print(image)
    }
    func imagePickerControllerDidCancel(){}
    func presentActionSheet() {
        // Créer du bouton "Choisir dans la galerie"
        let photoLibraryAction = UIAlertAction(title: "Choisir dans la galerie", style: .default) { (action) in
            // Appeler une fonction que nous devrons créer pour ouvrir la galerie d’iamges
            self.showImagePickerController(sourceType: .photoLibrary)
        }

        // Créer du bouton "Utiliser l’appareil photo"
        let cameraAction = UIAlertAction(title: "Utiliser l’appareil photo", style: .default) { (action) in
            // Appeler une fonction que nous devrons créer pour ouvrir l’appareil photo
            self.showImagePickerController(sourceType: .camera)
        }

        // Créer du bouton d’annulation
        let cancelAction = UIAlertAction(title: "Annuler", style: .cancel, handler: nil)

        // Créer de l’Action Sheet
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
      

        // Ajouter les trois boutons précédemment créés
        alert.addAction(photoLibraryAction)
        alert.addAction(cameraAction)
        alert.addAction(cancelAction)

        // Afficher de l’Action Sheeet
        self.present(alert, animated: true, completion: nil)
    }
    func showImagePickerController(sourceType: UIImagePickerController.SourceType) {
        // Instanciation d’un UIImagePickerController
        let imagePickerController = UIImagePickerController()

        // Le ProfileViewController a précédemment adopté le protocole UIImagePickerControllerDelegate
        // Il peut donc être le délégué de l’UIImagePickerController
        imagePickerController.delegate = self

        // La fonction showImagePickerController() prend un UIImagePickerController.SourceType en argument
        // Cet argument permet au UIImagePickerController d’utiliser soit la galerie, soit la caméra
        imagePickerController.sourceType = sourceType

        // Afficher l’UIImagePickerController
        present(imagePickerController, animated: true, completion: nil)
    }
}
extension ProfileViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //return movies.count
        return 10
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "postCell", for: indexPath) as? ProfilePostCell else {
            print("postCell :")
             return UICollectionViewCell()
         }

         //let movie = movies[indexPath.row]

         //cell.setUp(with: /*movie*/)

         return cell
     }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.item == 0 {
            photoType = .postImage
        }
        presentActionSheet()
    }
  
    //HEADER
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        guard let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "headerCell", for: indexPath) as? ProfileHeaderView else {
            print("ERREUR : viewForSupplementaryElementOfKind")
            return UICollectionReusableView()
        }
          print("VOIR :")
        if let user = user  {
               print("USER ? :")
               headerView.setUp(user: user, profileViewController: self)
        }
     
        print("USER : ", user)
        
        //Return du bon header
        return headerView
        
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
       return CGSize(width: collectionView.frame.width, height: 160)
       }
}

extension ProfileViewController: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return CGSize(width: (collectionView.frame.width / 3) - 2, height: (collectionView.frame.width / 3) - 2)
    }
}
