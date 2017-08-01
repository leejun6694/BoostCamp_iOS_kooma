//
//  DetailTableViewController.swift
//  ImageBoard
//
//  Created by JUN LEE on 2017. 8. 1..
//  Copyright © 2017년 LEEJUN. All rights reserved.
//

import UIKit

class DetailTableViewController: UIViewController {
    
    // MARK: Properties
    
    var images: Image!
    
    fileprivate lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = .black
        imageView.isUserInteractionEnabled = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    fileprivate lazy var nickNameLabel: UILabel = {
        let nickNameLabel = UILabel()
        
        nickNameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        return nickNameLabel
    }()
    
    fileprivate lazy var descLabel: UILabel = {
        let descLabel = UILabel()
        
        descLabel.translatesAutoresizingMaskIntoConstraints = false
        
        return descLabel
    }()
    
    fileprivate lazy var createdLabel: UILabel = {
        let createdLabel = UILabel()
        
        createdLabel.translatesAutoresizingMaskIntoConstraints = false
        
        return createdLabel
    }()
    
    // MARK: Functions
    
    func updateLabels() {
        let bodyFont = UIFont.preferredFont(forTextStyle: .body)
        nickNameLabel.font = bodyFont
        
        let captionFont = UIFont.preferredFont(forTextStyle: .caption1)
        descLabel.font = captionFont
        createdLabel.font = captionFont
    }
    
    // MARK: Overrride
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addSubview(imageView)
        self.view.addSubview(nickNameLabel)
        self.view.addSubview(createdLabel)
        self.view.addSubview(descLabel)
        
        self.view.addConstraints(imageViewConstraints())
        self.view.addConstraints(nickNameLabelConstraints())
        self.view.addConstraints(createdLabelConstraints())
        self.view.addConstraints(descLabelConstraints())
        
        updateLabels()
        
        let imageRequest = URLRequest(url: images.imageURL)
        let imageSession = URLSession.shared
        
        let task = imageSession.dataTask(with: imageRequest) {
            (data, response, error) -> Void in
            
            guard let imageData = data else{
                return
            }
            
            OperationQueue.main.addOperation {
                self.imageView.image = UIImage(data: imageData)
            }
        }
        
        nickNameLabel.text = images.authorNickName
        createdLabel.text = String(images.createdAt)
        descLabel.text = images.imageDesc
        
        self.navigationItem.title = images.imageTitle
        
        task.resume()
    }
}

// MARK: Layout Constraints

extension DetailTableViewController {
    
    fileprivate func imageViewConstraints() -> [NSLayoutConstraint] {
        let topConstraint = NSLayoutConstraint(item: imageView, attribute: .top, relatedBy: .equal, toItem: topLayoutGuide, attribute: .bottom, multiplier: 1.0, constant: 0.0)
        let leadingConstraint = NSLayoutConstraint(item: imageView, attribute: .leading, relatedBy: .equal, toItem: view, attribute: .leading, multiplier: 1.0, constant: 0.0)
        let trailingConstraint = NSLayoutConstraint(item: imageView, attribute: .trailing, relatedBy: .equal, toItem: view, attribute: .trailing, multiplier: 1.0, constant: 0.0)
        let heightConstraint = NSLayoutConstraint(item: imageView, attribute: .height, relatedBy: .equal, toItem: view, attribute: .height, multiplier: 0.4, constant: 0.0)
        
        return [topConstraint, leadingConstraint, trailingConstraint, heightConstraint]
    }
    
    fileprivate func nickNameLabelConstraints() -> [NSLayoutConstraint] {
        let topConstraint = NSLayoutConstraint(item: nickNameLabel, attribute: .top, relatedBy: .equal, toItem: imageView, attribute: .bottom, multiplier: 1.0, constant: 8.0)
        let leadingConstraint = NSLayoutConstraint(item: nickNameLabel, attribute: .leading, relatedBy: .equal, toItem: view, attribute: .leading, multiplier: 1.0, constant: 8.0)
        
        return [topConstraint, leadingConstraint]
    }
    
    fileprivate func createdLabelConstraints() -> [NSLayoutConstraint] {
        let centerYConstraint = NSLayoutConstraint(item: createdLabel, attribute: .centerY, relatedBy: .equal, toItem: nickNameLabel, attribute: .centerY, multiplier: 1.0, constant: 0.0)
        let trailingConstraint = NSLayoutConstraint(item: createdLabel, attribute: .trailing, relatedBy: .equal, toItem: view, attribute: .trailing, multiplier: 1.0, constant: -8.0)
        
        return [centerYConstraint, trailingConstraint]
    }
    
    fileprivate func descLabelConstraints() -> [NSLayoutConstraint] {
        let topConstraint = NSLayoutConstraint(item: descLabel, attribute: .top, relatedBy: .equal, toItem: nickNameLabel, attribute: .bottom, multiplier: 1.0, constant: 8.0)
        let leadingConstraint = NSLayoutConstraint(item: descLabel, attribute: .leading, relatedBy: .equal, toItem: nickNameLabel, attribute: .leading, multiplier: 1.0, constant: 0.0)
        
        return [topConstraint, leadingConstraint]
    }
    
}
