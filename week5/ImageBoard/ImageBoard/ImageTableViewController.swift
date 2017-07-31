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
    
    let imagetableCell: ImageTableViewCell = ImageTableViewCell()
    
    fileprivate lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        return tableView
    }()
    
    // MARK: Override
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addSubview(tableView)
        self.view.addConstraints(tableViewConstraints())
    }
}

// MARK: Delegate

extension ImageTableViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        tableView.register(ImageTableViewCell.self, forCellReuseIdentifier: "ImageTableViewCell")
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ImageTableViewCell", for: indexPath) as! ImageTableViewCell
        
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
