//
//  EditProfileViewController.swift
//  TestStoryMap
//
//  Created by Anatolii Bogdanov on 27.09.2020.
//

import UIKit
import RealmSwift

class EditProfileViewController: UIViewController {
    @IBOutlet var animalAvatarViews: [ShadowView]!
    @IBOutlet weak var userAvatarShadowView: ShadowView!
    @IBOutlet weak var saveButtonView: UIButton!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var uploadButtonView: UIStackView!
    @IBOutlet weak var avatarImageView: RoundImageView!
    @IBOutlet weak var uploadhintLabel: UILabel!
    
    var selectedAnimal: String?
    var finalImage: String?
    var isKeyboardAppear = false
    var finalImageDefault: Bool = true {
        willSet {
            uploadhintLabel.textColor = .gray
        }
    }
    
    var imagePickercontroller = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = K.editProfileNavBarTitle
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        if animalAvatarViews.count != 0 {
            
            setUpButtonsActions()
            setUpUI()
        }
    }
    
    func setUpUI() {
        userAvatarShadowView.drawShadow()
        
        saveButtonView.layer.cornerRadius = 8
        
        for animalAvatarView in animalAvatarViews {
            let cornerRadius = CGFloat(animalAvatarView.frame.width / 2)
            animalAvatarView.subviews[0].layer.cornerRadius = cornerRadius
            animalAvatarView.subviews[0].clipsToBounds = true
            animalAvatarView.layer.shadowOpacity = 0
        }
    }
    
    func setUpButtonsActions() {
        let tapPath = UITapGestureRecognizer(target: self, action: #selector(self.handleTapUploadPath(_:)))
        uploadButtonView.addGestureRecognizer(tapPath)
        
        for animalAvatarView in animalAvatarViews {
            guard animalAvatarView.restorationIdentifier != nil else {return}
            let tapPath = UITapGestureRecognizer(target: self, action: #selector(self.handleTapIconPath(_:)))
            animalAvatarView.addGestureRecognizer(tapPath)
            animalAvatarView.isUserInteractionEnabled = true
        }
    }
    
    @objc func handleTapIconPath(_ sender: UITapGestureRecognizer? = nil) {
        guard let sender = sender, let view = sender.view else { return }
        selectedAnimal = view.restorationIdentifier
        for animalAvatarView in animalAvatarViews {
            if animalAvatarView.restorationIdentifier != selectedAnimal {
                animalAvatarView.removeShadow()
            } else {
                animalAvatarView.drawShadow()
                guard let image = selectedAnimal else { return }
                avatarImageView.image = UIImage(named: image)
                finalImage = image
                finalImageDefault = true
            }
            animalAvatarView.layer.shadowOffset = CGSize(width: 0, height: 2)
        }
    }
    
    @objc func handleTapUploadPath(_ sender: UITapGestureRecognizer? = nil) {
        self.showAlert()
    }
    
    private func showAlert() {
        let alert = UIAlertController(title: "Image Selection", message: "From where you want to pick this image?", preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Camera", style: .default, handler: {(action: UIAlertAction) in
            self.getImage(fromSourceType: .camera)
        }))
        alert.addAction(UIAlertAction(title: "Photo Album", style: .default, handler: {(action: UIAlertAction) in
            self.getImage(fromSourceType: .photoLibrary)
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .destructive, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    private func getImage(fromSourceType sourceType: UIImagePickerController.SourceType) {
        
        //Check is source type available
        if UIImagePickerController.isSourceTypeAvailable(sourceType) {
            
            let imagePickerController = UIImagePickerController()
            imagePickerController.delegate = self
            imagePickerController.sourceType = sourceType
            self.present(imagePickerController, animated: true, completion: nil)
        }
    }
    
    @IBAction func saveButtonPressed(_ sender: Any) {
        if textField.text == nil || textField.text!.isEmpty || finalImage == nil {
            showSavingWarning()
        } else if let image = avatarImageView.image, let userName = textField.text {
            if finalImageDefault {
                guard let imageName = finalImage else { return }
                writeDataToRealm(imageName: imageName, userName: userName)
            } else {
                DataBaseHelper.shareInstance.deleteImage()
                DataBaseHelper.shareInstance.saveImage(data: image.pngData()!)
                writeDataToRealm(userName: userName)
            }
            navigationController?.popViewController(animated: true)
        }
    }
    
    func writeDataToRealm(imageName: String = "", userName: String) {
        let realm = try! Realm()
        let users = realm.objects(UserProfile.self)
        
        try! realm.write {
            users.first?.setValue(userName, forKey: "name")
            users.first?.setValue(imageName, forKey: "avatar")
            users.first?.setValue(finalImageDefault, forKey: "defaultImage")
        }
    }
    
    @IBAction func cancelButtonPressed(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    func showSavingWarning() {
        uploadhintLabel.textColor = .red
        guard let placeholder = textField.placeholder else { return }
        textField.attributedPlaceholder =  NSAttributedString(string: placeholder,
                                     attributes: [NSAttributedString.Key.foregroundColor: UIColor.red])
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if !isKeyboardAppear {
            if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
                if self.view.frame.origin.y == 0{
                    self.view.frame.origin.y -= (keyboardSize.height - 50)
                }
            }
            isKeyboardAppear = true
        }
    }

    @objc func keyboardWillHide(notification: NSNotification) {
        if isKeyboardAppear {
            if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
                if self.view.frame.origin.y != 0{
                    self.view.frame.origin.y += keyboardSize.height
                }
            }
             isKeyboardAppear = false
        }
    }
}

extension EditProfileViewController: UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        self.dismiss(animated: true) { [weak self] in
            guard let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else { return }
            self?.avatarImageView.image = image
            self?.avatarImageView.contentMode = .scaleAspectFill
            self?.finalImageDefault = false
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
}
