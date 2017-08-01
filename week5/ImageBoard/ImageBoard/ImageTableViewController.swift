//
//  ImageTableViewController.swift
//  ImageBoard
//
//  Created by JUN LEE on 2017. 7. 31..
//  Copyright © 2017년 LEEJUN. All rights reserved.
//

import UIKit

class ImageTableViewController: UIViewController {
    
    // MARK: Properties
    
    var images = [Image]()
    var store: ImageStore = ImageStore()
    
    let imagetableCell: ImageTableViewCell = ImageTableViewCell()
    
    fileprivate lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        return tableView
    }()
    
    // MARK: Override
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.view.addSubview(tableView)
        self.view.addConstraints(tableViewConstraints())
//        self.tableView.delegate = self
//        self.tableView.dataSource = self
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        if appDelegate.session != nil {
            store.imageLoad() {
                (imageResult) -> Void in
                
                switch imageResult {
                case let .ok(image):
                    print(image.count)
                    self.images = image
                case let .fail(error):
                    print(error)
                    self.images.removeAll()
                }
                self.tableView.reloadData()
            }
        }
    }
}

// MARK: Delegate

extension ImageTableViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.images.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        tableView.register(ImageTableViewCell.self, forCellReuseIdentifier: "ImageTableViewCell")
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ImageTableViewCell", for: indexPath) as! ImageTableViewCell
        let imageItem = self.images[indexPath.row]
        
        cell.createTitleLabel()
        cell.createCreatedLabel()
        cell.createNickNameLabel()
        cell.createCellImageView()
        
        cell.titleLabel.text = imageItem.imageTitle
        cell.nickNameLabel.text = imageItem.authorNickName
        cell.createdLabel.text = String(imageItem.createdAt)
        
        return cell
    }
}

// MARK: Layout Constraints

extension ImageTableViewController {
    fileprivate func tableViewConstraints() -> [NSLayoutConstraint] {
        let topConstraint = NSLayoutConstraint(item: tableView, attribute: .top, relatedBy: .equal, toItem: topLayoutGuide, attribute: .bottom, multiplier: 1.0, constant: 0.0)
        let leadingConstraint = NSLayoutConstraint(item: tableView, attribute: .leading, relatedBy: .equal, toItem: view, attribute: .leading, multiplier: 1.0, constant: 0.0)
        let bottomConstraint = NSLayoutConstraint(item: tableView, attribute: .bottom, relatedBy: .equal, toItem: bottomLayoutGuide, attribute: .top, multiplier: 1.0, constant: 0.0)
        let trailingConstraint = NSLayoutConstraint(item: tableView, attribute: .trailing, relatedBy: .equal, toItem: view, attribute: .trailing, multiplier: 1.0, constant: 0.0)
        
        return [topConstraint, leadingConstraint, bottomConstraint, trailingConstraint]
    }
}
