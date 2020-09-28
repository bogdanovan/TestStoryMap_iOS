//
//  ProfileVC.swift
//  TestStoryMap
//
//  Created by Anatolii Bogdanov on 23.09.2020.
//

import UIKit
import RealmSwift

class ProfileVC: UIViewController, UIImagePickerControllerDelegate {
    
    @IBOutlet weak var userAvatarImageView: RoundImageView!
    @IBOutlet weak var userAvatarShadowView: ShadowView!
    @IBOutlet weak var QRCodeImageView: UIImage!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var QRView: ShadowView!
    @IBOutlet weak var QRShadowView: ShadowView!
    
    var defaultUser = UserProfile()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = K.userProfileNavBarTitle
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        getTheUser()
    }
    
    func getTheUser() {
        let realm = try! Realm()
        let users = realm.objects(UserProfile.self)
        
        if let currentUser = users.first {
            setupUI(user: currentUser)
        } else {
            defaultUser.name = "Default name"
            defaultUser.avatar = "profile_icon"
            defaultUser.defaultImage = true
            let defaultImage = UIImage(named: defaultUser.avatar!)
            DataBaseHelper.shareInstance.saveImage(data: defaultImage!.pngData()!)
            try! realm.write {
                realm.add(defaultUser)
            }
            
            setupUI(user: defaultUser)
        }
    }
    
    func setupUI(user: UserProfile ) {
        let QRRadius = CGFloat(5)
        QRView.layer.cornerRadius = QRRadius
        QRView.clipsToBounds = true
        QRShadowView.drawShadow()
        userAvatarShadowView.drawShadow()
        
        userNameLabel.text = user.name
        
        guard let avatar = user.avatar else { return }
        if user.defaultImage {
            userAvatarImageView.image = UIImage(named: avatar)
        } else {
            let arr = DataBaseHelper.shareInstance.fetchImage()
            userAvatarImageView.image = UIImage(data: arr.last!.img!)
        }
        
    }    
}
