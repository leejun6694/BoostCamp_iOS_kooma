//
//  AddImageController.swift
//  ImageBoard
//
//  Created by JUN LEE on 2017. 8. 2..
//  Copyright © 2017년 LEEJUN. All rights reserved.
//

import UIKit

class AddImageController: UIViewController, UIGestureRecognizerDelegate {
    
    // MARK: Properties
    
    let imageStore = ImageStore()
    
    fileprivate lazy var toolbar: UIToolbar = {
        let toolbar = UIToolbar()
        toolbar.translatesAutoresizingMaskIntoConstraints = false
        
        return toolbar
    }()
    
    fileprivate lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = .black
        imageView.isUserInteractionEnabled = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    fileprivate lazy var cancelButton: UIBarButtonItem =  {
        let cancelButton = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(clickCancelButton(_:)))
        
        return cancelButton
    }()
    
    fileprivate lazy var flexibleSpace: UIBarButtonItem = {
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        
        return flexibleSpace
    }()
    
    fileprivate lazy var imageTitle: UIBarButtonItem = {
        let titleField = UITextField(frame: CGRect(x: 0.0, y: 0.0, width: 200.0, height: 30.0))
        titleField.borderStyle = .roundedRect
        titleField.textAlignment = .center
        
        let imageTitle = UIBarButtonItem(customView: titleField)
        imageTitle.title = titleField.text
        
        return imageTitle
    }()
    
    fileprivate lazy var doneButton: UIBarButtonItem = {
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(clickDoneButton(_:)))
        
        return doneButton
    }()
    
    fileprivate lazy var textView: UITextView = {
        let textView = UITextView()
        
        return textView
    }()
    
    // MARK: Functions
    
    @objc fileprivate func clickCancelButton(_ sender: AnyObject) {
        dismiss(animated: true, completion: nil)
    }
    
    @objc fileprivate func clickDoneButton(_ sender: AnyObject) {
//        guard
//            let title = imageTitle.title,
//            let image = imageView.image,
//            let imageData = UIImageJPEGRepresentation(image, 0.3) else {
//            return
//        }
//        let desc: String? = textView.text
//        
//        imageStore.createImage(title: title, desc: desc, imageData: imageData) {
//            (createResult) -> Void in
//            
//            switch createResult {
//            case .sucess:
//            case .fail(error):
//                
//            }
//        }
    }

    @objc fileprivate func clickImageView(_ sender: UITapGestureRecognizer) {
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = .photoLibrary
        imagePicker.allowsEditing = true
        imagePicker.delegate = self
        self.present(imagePicker, animated: true, completion: nil)
    }
    
    // MARK: Override
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addSubview(toolbar)
        self.view.addSubview(imageView)
        toolbar.items = [cancelButton, flexibleSpace, imageTitle, flexibleSpace, doneButton]
        self.view.addSubview(textView)
        
        self.view.addConstraints(toolbarConstraints())
        self.view.addConstraints(imageViewConstraints())
        self.view.addConstraints(textViewConstraints())
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(clickImageView(_:)))
        tapGesture.delegate = self
        self.imageView.addGestureRecognizer(tapGesture)
    }
    
}

// MARK: Delegate

extension AddImageController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        guard let selectedImage = info[UIImagePickerControllerEditedImage] as? UIImage else {
            fatalError()
        }
        
        self.imageView.image = selectedImage
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
}

// MARK: Layout Constraints

extension AddImageController {
    
    fileprivate func toolbarConstraints() -> [NSLayoutConstraint] {
        let topConstraint = NSLayoutConstraint(item: toolbar, attribute: .top, relatedBy: .equal, toItem: topLayoutGuide, attribute: .bottom, multiplier: 1.0, constant: 0.0)
        let leadingConstraint = NSLayoutConstraint(item: toolbar, attribute: .leading, relatedBy: .equal, toItem: view, attribute: .leading, multiplier: 1.0, constant: 0.0)
        let trailingConstraint = NSLayoutConstraint(item: toolbar, attribute: .trailing, relatedBy: .equal, toItem: view, attribute: .trailing, multiplier: 1.0, constant: 0.0)
        
        return [topConstraint, leadingConstraint, trailingConstraint]
    }
    
    fileprivate func imageViewConstraints() -> [NSLayoutConstraint] {
        let topConstraint = NSLayoutConstraint(item: imageView, attribute: .top, relatedBy: .equal, toItem: toolbar, attribute: .bottom, multiplier: 1.0, constant: 0.0)
        let leadingConstraint = NSLayoutConstraint(item: imageView, attribute: .leading, relatedBy: .equal, toItem: view, attribute: .leading, multiplier: 1.0, constant: 0.0)
        let trailingConstraint = NSLayoutConstraint(item: imageView, attribute: .trailing, relatedBy: .equal, toItem: view, attribute: .trailing, multiplier: 1.0, constant: 0.0)
        let heightConstraint = NSLayoutConstraint(item: imageView, attribute: .height, relatedBy: .equal, toItem: view, attribute: .height, multiplier: 0.4, constant: 0.0)
        
        return [topConstraint, leadingConstraint, trailingConstraint, heightConstraint]
    }
    
    fileprivate func textViewConstraints() -> [NSLayoutConstraint] {
        let topConstraint = NSLayoutConstraint(item: textView, attribute: .top, relatedBy: .equal, toItem: view, attribute: .centerY, multiplier: 1.0, constant: 0.0)
        let leadingConstraint = NSLayoutConstraint(item: textView, attribute: .leading, relatedBy: .equal, toItem: view, attribute: .leading, multiplier: 1.0, constant: 0.0)
        let bottomConstraint = NSLayoutConstraint(item: textView, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1.0, constant: 0.0)
        let trailingConstraint = NSLayoutConstraint(item: textView, attribute: .trailing, relatedBy: .equal, toItem: view, attribute: .trailing, multiplier: 1.0, constant: 0.0)
        
        return [topConstraint, leadingConstraint, bottomConstraint, trailingConstraint]
    }
}
