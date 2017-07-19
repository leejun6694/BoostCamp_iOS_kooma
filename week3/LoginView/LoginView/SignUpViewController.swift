//
//  SignUpViewController.swift
//  LoginView
//
//  Created by JUN LEE on 2017. 7. 8..
//  Copyright © 2017년 LEEJUN. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    // MARK: Properties
    
    @IBOutlet var idField: UITextField!
    @IBOutlet var pwField: UITextField!
    @IBOutlet var confirmField: UITextField!
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var textView: UITextView!
    var cancelButton: MyButton!
    var signUpButton: MyButton!

    // 이미지 피커
    private lazy var imagePickerController: UIImagePickerController = {
        let imagePickerController = UIImagePickerController()
        imagePickerController.sourceType = .photoLibrary
        imagePickerController.allowsEditing = true
        imagePickerController.delegate = self
        return imagePickerController
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        idField.delegate = self
        pwField.delegate = self
        confirmField.delegate = self
        
        cancelButton = MyButton()
        signUpButton = MyButton()
        
        self.view.addSubview(cancelButton)
        self.view.addSubview(signUpButton)
        
        cancelButton.translatesAutoresizingMaskIntoConstraints = false
        signUpButton.translatesAutoresizingMaskIntoConstraints = false
        cancelButton.topAnchor.constraint(equalTo: textView.bottomAnchor, constant: 8).isActive = true
        cancelButton.leadingAnchor.constraint(equalTo: textView.leadingAnchor).isActive = true
        signUpButton.topAnchor.constraint(equalTo: cancelButton.topAnchor).isActive = true
        signUpButton.trailingAnchor.constraint(equalTo: textView.trailingAnchor).isActive = true
        signUpButton.leadingAnchor.constraint(equalTo: cancelButton.trailingAnchor, constant: 8).isActive = true
        signUpButton.widthAnchor.constraint(equalTo: cancelButton.widthAnchor).isActive = true
        signUpButton.heightAnchor.constraint(equalTo: cancelButton.heightAnchor).isActive = true
        signUpButton.bottomAnchor.constraint(equalTo: bottomLayoutGuide.topAnchor, constant: -8).isActive = true
        
        cancelButton.setTitle("Cancel", state: .normal)
        cancelButton.setTitleColor(.red, state: .normal)
        signUpButton.setTitle("Sign Up", state: .normal)
        signUpButton.setTitleColor(.blue, state: .normal)
        
        cancelButton.addTarget(self, action: #selector(clickCancelButton(_:)), event: .touchUpInside)
        signUpButton.addTarget(self, action: #selector(clickSignUpButton(sender:)), event: .touchUpInside)
    }
    
    // MARK: Functions
    
    func clickCancelButton(_ sender: AnyObject) {
        dismiss(animated: true, completion: nil)
    }
    
    func clickSignUpButton(sender: AnyObject) {
        if pwField.text == confirmField.text {
            dismiss(animated: true, completion: nil)
        }
        else {
            print("check password")
        }
    }
    
    // MARK: UITextFieldDelegate
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        return true
    }
    
    // MARK: UIImagePickerControllerDelegate
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        guard let selectImage = info[UIImagePickerControllerOriginalImage] as? UIImage else {
            fatalError("Expected a dictionary containing an image, but was provided the following: \(info)")
        }
        
        imageView.image = selectImage
        dismiss(animated: true, completion: nil)
    }

    // MARK: Actions
    
    @IBAction func dismissKeyboard(sender: AnyObject) {
        idField.resignFirstResponder()
        pwField.resignFirstResponder()
        confirmField.resignFirstResponder()
        textView.resignFirstResponder()
    }
    
    @IBAction func selectImageFromPhotoLibrary(_ sender: UITapGestureRecognizer) {
        idField.resignFirstResponder()
        pwField.resignFirstResponder()
        confirmField.resignFirstResponder()
        textView.resignFirstResponder()
        
        // 사용자가 이미지 피커를 여러 번 볼 수도 있다는 가정을 하면, 이미지 피커를 매 번 생성하지 않고, 프로퍼티로 활용해 보는 것은 어떨런지
        present(imagePickerController, animated: true, completion: nil)
    }
}
