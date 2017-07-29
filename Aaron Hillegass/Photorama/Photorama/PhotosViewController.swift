//
//  PhotosViewController.swift
//  Photorama
//
//  Created by JUN LEE on 2017. 7. 29..
//  Copyright © 2017년 LEEJUN. All rights reserved.
//

import UIKit

class PhotosViewController: UIViewController {
    
    @IBOutlet var imageView: UIImageView!
    var store: PhotoStore!
    
    func updateImageView(for photo: Photo) {
        store.fetchImage(for: photo) {
            (imageResult) -> Void in
            
            switch imageResult {
            case let .success(image):
                self.imageView.image = image
            case let .failure(error):
                print("Error downloading image: \(error)")
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        store.fetchInterstingPhotos() {
            (photoResult) -> Void in
            
            switch photoResult {
            case let .success(photos):
                print("Successfully found \(photos.count) photos.")
                if let firstPhoto = photos.first {
                    self.updateImageView(for: firstPhoto)
                }
            case let .failure(error):
                print("Error fetching interesting photos: \(error)")
            }
        }
    }
}
