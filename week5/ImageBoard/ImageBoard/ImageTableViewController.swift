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
    
    fileprivate lazy var addButton: UIBarButtonItem =  {
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(clickAddButton(_:)))
        
        return addButton
    }()
    
    // MARK: Actions
    
    @objc fileprivate func clickAddButton(_ sender: AnyObject) {
        performSegue(withIdentifier: "segueTableToAdd", sender: self)
    }
    
    func refreshControl(_ refreshControl: UIRefreshControl) {
        store.imageLoad() {
            (imageResult) -> Void in
            
            switch imageResult {
            case let .ok(image):
                self.images = image
            case let .fail(error):
                print(error)
                self.images.removeAll()
            }
            self.tableView.reloadData()
            refreshControl.endRefreshing()
        }
    }
    
    // MARK: Override
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        navigationItem.leftBarButtonItem = addButton
        
        self.view.addSubview(tableView)
        self.view.addConstraints(tableViewConstraints())
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refreshControl(_:)), for: .valueChanged)
        
        if #available(iOS 10.0, *) {
            self.tableView.refreshControl = refreshControl
        } else {
            self.tableView.backgroundView = refreshControl
        }
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        if appDelegate.session != nil {
            store.imageLoad() {
                (imageResult) -> Void in
                
                switch imageResult {
                case let .ok(image):
                    self.images = image
                case let .fail(error):
                    print(error)
                    self.images.removeAll()
                }
                self.tableView.reloadData()
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueTableToDetail" {
            
            if let row = tableView.indexPathForSelectedRow?.row {
                
                let imageItem = self.images[row]
                let detailViewController = segue.destination as! DetailTableViewController
                detailViewController.images = imageItem
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
        
        cell.createCellImageView()
        cell.createTitleLabel()
        cell.createNickNameLabel()
        cell.createCreatedLabel()
        cell.updateLabels()
        
        cell.titleLabel.text = imageItem.imageTitle
        cell.nickNameLabel.text = imageItem.authorNickName
        cell.createdLabel.text = String(imageItem.createdAt)
        
        let imageRequest = URLRequest(url: imageItem.thumbImageURL)
        let imageSession = URLSession.shared
        
        let task = imageSession.dataTask(with: imageRequest) {
            (data, response, error) -> Void in
            
            guard let imageData = data else{
                return
            }
            
            OperationQueue.main.addOperation {
                cell.cellImageView.image = UIImage(data: imageData)
            }
        }
        task.resume()
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "segueTableToDetail", sender: self)
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
