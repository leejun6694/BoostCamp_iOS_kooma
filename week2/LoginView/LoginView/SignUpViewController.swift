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
    
    override func viewDidLoad() {
        idField.delegate = self
        pwField.delegate = self
        confirmField.delegate = self
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
        
        let imagePickerController = UIImagePickerController()
        imagePickerController.sourceType = .photoLibrary
        
        imagePickerController.delegate = self
        present(imagePickerController, animated: true, completion: nil)
    }    
}
