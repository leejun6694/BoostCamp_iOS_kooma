//
//  DetailViewController.swift
//  Homepwner
//
//  Created by JUN LEE on 2017. 7. 22..
//  Copyright © 2017년 LEEJUN. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController, UITextFieldDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    // MARK: Properties
    
    @IBOutlet var nameField: MyTextField!
    @IBOutlet var serialNumberField: MyTextField!
    @IBOutlet var valueField: MyTextField!
    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var imageView: UIImageView!
    
    var item: Item! {
        didSet {
            navigationItem.title = item.name
        }
    }
    var imageStore: ImageStore!
    
    let numberFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2        
        
        return formatter
    }()
    
    let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        
        return formatter
    }()
    
    // MARK: Functions
    
    @IBAction func backgroundTapped(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        return true
    }
    
    @IBAction func takePicture(_ sender: UIBarButtonItem) {
        let imagePicker = UIImagePickerController()
        
        // 기기에  카메라가 있으면 사진을 찍는다
        // 아니면 사진 라이브러리에서 사진을 고른다
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            imagePicker.sourceType = .camera
        }
        else {
            imagePicker.sourceType = .photoLibrary
        }
        
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        
        // 화면에 이미지 피커를 표시한다
        present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        // 딕셔너리에서 선택된 이미지를 가져온다
        let image = info[UIImagePickerControllerEditedImage] as! UIImage
        
        // 이미지를 item의 키로 ImageStore 안에 저장한다
        imageStore.setImage(image: image, forKey: item.itemKey)
        
        // 화면상의 이미지를 이미지 뷰에 넣는다
        imageView.image = image
        
        // 이미지 피커를 화면에서 사라지게 한다
        // 반드시 이 dismiss 메서드를 호출해야 한다
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func removeImage(_ sender: UIBarButtonItem) {
        imageStore.deleteImageForKey(key: item.itemKey)
        imageView.image = nil
    }
    
    // MARK: Override
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        nameField.text = item.name
        serialNumberField.text = item.serialNumber
//        valueField.text = "\(item.valueInDollars)"
//        dateLabel.text = "\(item.dateCreate)"
        valueField.text = numberFormatter.string(from: NSNumber(value: item.valueInDollars))
        dateLabel.text = dateFormatter.string(from: item.dateCreated)
        
        // 물품 키를 가져온다
        let key = item.itemKey
        
        // 물품과 연결된 이미지가 있으면
        // 이미지 뷰에 그 이미지를 표시한다
        let imageToDisplay = imageStore.imageForKey(key: key)
        imageView.image = imageToDisplay
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // 퍼스트 리스폰더를 정리한다
        view.endEditing(true)
        
        // 변경 사항을 Item에 저장한다
        item.name = nameField.text ?? ""
        item.serialNumber = serialNumberField.text
        
        if let valueText = valueField.text, let value = numberFormatter.number(from: valueText) {
                item.valueInDollars = value.intValue
        } else {
            item.valueInDollars = 0
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueChangeDate" {
            let destination = segue.destination as! ChangeDateViewController
            destination.item = item
        }
    }
}
