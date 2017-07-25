//
//  HistoryViewController.swift
//  OneToTwentyFive
//
//  Created by JUN LEE on 2017. 7. 23..
//  Copyright © 2017년 LEEJUN. All rights reserved.
//

import UIKit

class HistoryViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    // MARK: Properties

    var recordStore: RecordStore!
    var recordCell: RecordCell! = RecordCell()
    
    let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        formatter.timeStyle = .medium
        
        return formatter
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        return tableView
    }()
    
    private lazy var headerLabel: UILabel = {
        let headerLabel = UILabel()
        let RGBpoint: CGFloat = 255.0
        headerLabel.text = "HISTORY"
        headerLabel.textColor = UIColor(red: 111.0/RGBpoint, green: 167.0/RGBpoint, blue: 145.0/RGBpoint, alpha: 1.0)
        headerLabel.textAlignment = .center
        headerLabel.font = UIFont(name: headerLabel.font.fontName, size: 30.0)
        headerLabel.translatesAutoresizingMaskIntoConstraints = false
        
        return headerLabel
    }()
    
    private lazy var footerView: UIView = {
        let footerView = UIView()
        footerView.translatesAutoresizingMaskIntoConstraints = false
        
        return footerView
    }()
   
    private lazy var closeButton: UIButton = {
        let closeButton = UIButton(type: .system)
        let RGBpoint: CGFloat = 255.0
        closeButton.setTitle("Close", for: .normal)
        closeButton.setTitleColor(.white, for: .normal)
        closeButton.backgroundColor = UIColor(red: 220.0/RGBpoint, green: 125.0/RGBpoint, blue: 104.0/RGBpoint, alpha: 1.0)
        closeButton.translatesAutoresizingMaskIntoConstraints = false
        
        closeButton.addTarget(self, action: #selector(clickCloseButton(_:)), for: .touchUpInside)
        
        return closeButton
    }()
    
    private lazy var resetButton: UIButton = {
        let resetButton = UIButton(type: .system)
        let RGBpoint: CGFloat = 255.0
        resetButton.setTitle("Reset", for: .normal)
        resetButton.setTitleColor(.white, for: .normal)
        resetButton.backgroundColor = UIColor(red: 220.0/RGBpoint, green: 125.0/RGBpoint, blue: 104.0/RGBpoint, alpha: 1.0)
        resetButton.translatesAutoresizingMaskIntoConstraints = false
        
        resetButton.addTarget(self, action: #selector(clickResetButton(_:)), for: .touchUpInside)
        
        return resetButton
    }()
    
    // MARK: Actions
    
    func clickCloseButton(_ sender: AnyObject) {
        dismiss(animated: true, completion: nil)
    }
    
    func clickResetButton(_ sender: AnyObject) {
        let alertTitle = "REALLY?"
        let alert = UIAlertController(title: alertTitle, message: "", preferredStyle: .alert)
        let noAction = UIAlertAction(title: "NO", style: .cancel, handler: nil)
        alert.addAction(noAction)
        let yesAction = UIAlertAction(title: "YES", style: .destructive, handler: {
            [unowned self, tableView] (action) -> Void in
            
            self.recordStore.allRecords = []
            tableView.reloadData()
        })
        alert.addAction(yesAction)
        
        present(alert, animated: true, completion: nil)
    }
    
    // MARK: Delegate
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recordStore.allRecords.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        tableView.register(RecordCell.self, forCellReuseIdentifier: "RecordCell")
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "RecordCell", for: indexPath) as! RecordCell
        let recordItem = recordStore.allRecords[indexPath.row]
        
        cell.createNameLabel()
        cell.createRecordLabel()
        cell.createDateCreatedLabel()
        cell.updateLabels()
        
        let minute = recordItem.record / 6000
        let second = (recordItem.record % 6000) / 100
        let miliSecond = (recordItem.record % 6000) % 100
        cell.recordLabel.text = String(format: "%02i:%02i:%02i", minute, second, miliSecond)
        cell.nameLabel.text = recordItem.name
        cell.dateCreatedLabel.text = "(" + dateFormatter.string(from: recordItem.dateCreated) + ")"
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let record = recordStore.allRecords[indexPath.row]
            
            recordStore.removeRecord(record: record)
            
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }

    // MARK: Override
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(tableView)
        view.addSubview(headerLabel)
        view.addSubview(footerView)
        footerView.addSubview(closeButton)
        footerView.addSubview(resetButton)
        
        view.addConstraints(tableViewConstraint())
        view.addConstraints(headerLabelConstraint())
        view.addConstraints(footerViewConstraint())
        footerView.addConstraints(closeButtonConstraint())
        footerView.addConstraints(resetButtonConstraint())
        
        tableView.dataSource = self
        tableView.delegate = self
        
        // section footer view
        tableView.tableFooterView = UIView()
    }
    
    // MARK: Constraint
    
    private func tableViewConstraint() -> [NSLayoutConstraint] {
        let topConstraint = NSLayoutConstraint(item: tableView, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1.0, constant: 80)
        let leadingConstraint = NSLayoutConstraint(item: tableView, attribute: .leading, relatedBy: .equal, toItem: view, attribute: .leading, multiplier: 1.0, constant: 0.0)
        let bottomConstraint = NSLayoutConstraint(item: tableView, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1.0, constant: -45.0)
        let trailingConstraint = NSLayoutConstraint(item: tableView, attribute: .trailing, relatedBy: .equal, toItem: view, attribute: .trailing, multiplier: 1.0, constant: 0.0)
        
        return [topConstraint, leadingConstraint, bottomConstraint, trailingConstraint]
    }
    
    private func headerLabelConstraint() -> [NSLayoutConstraint] {
        let topConstraint = NSLayoutConstraint(item: headerLabel, attribute: .top, relatedBy: .equal, toItem: topLayoutGuide, attribute: .bottom, multiplier: 1.0, constant: 0.0)
        let leadingConstraint = NSLayoutConstraint(item: headerLabel, attribute: .leading, relatedBy: .equal, toItem: view, attribute: .leading, multiplier: 1.0, constant: 0.0)
        let bottomConstraint = NSLayoutConstraint(item: headerLabel, attribute: .bottom, relatedBy: .equal, toItem: tableView, attribute: .top, multiplier: 1.0, constant: 0.0)
        let trailingConstraint = NSLayoutConstraint(item: headerLabel, attribute: .trailing, relatedBy: .equal, toItem: view, attribute: .trailing, multiplier: 1.0, constant: 0.0)
        
        return [topConstraint, leadingConstraint, bottomConstraint, trailingConstraint]
    }
    
    private func footerViewConstraint() -> [NSLayoutConstraint] {
        let topConstraint = NSLayoutConstraint(item: footerView, attribute: .top, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1.0, constant: -45.0)
        let leadingConstraint = NSLayoutConstraint(item: footerView, attribute: .leading, relatedBy: .equal, toItem: view, attribute: .leading, multiplier: 1.0, constant: 0.0)
        let bottomConstraint = NSLayoutConstraint(item: footerView, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1.0, constant: 0.0)
        let trailingConstraint = NSLayoutConstraint(item: footerView, attribute: .trailing, relatedBy: .equal, toItem: view, attribute: .trailing, multiplier: 1.0, constant: 0.0)
        
        return [topConstraint, leadingConstraint, bottomConstraint, trailingConstraint]
    }
    
    private func closeButtonConstraint() -> [NSLayoutConstraint] {
        let topConstraint = NSLayoutConstraint(item: closeButton, attribute: .top, relatedBy: .equal, toItem: footerView, attribute: .top, multiplier: 1.0, constant: 0.0)
        let leadingConstraint = NSLayoutConstraint(item: closeButton, attribute: .leading, relatedBy: .equal, toItem: footerView, attribute: .leading, multiplier: 1.0, constant: 0.0)
        let bottomConstraint = NSLayoutConstraint(item: closeButton, attribute: .bottom, relatedBy: .equal, toItem: footerView, attribute: .bottom, multiplier: 1.0, constant: 0.0)
        
        return [topConstraint, leadingConstraint, bottomConstraint]
    }
    
    private func resetButtonConstraint() -> [NSLayoutConstraint] {
        let topConstraint = NSLayoutConstraint(item: resetButton, attribute: .top, relatedBy: .equal, toItem: footerView, attribute: .top, multiplier: 1.0, constant: 0.0)
        let trailingConstraint = NSLayoutConstraint(item: resetButton, attribute: .trailing, relatedBy: .equal, toItem: footerView, attribute: .trailing, multiplier: 1.0, constant: 0.0)
        let bottomConstraint = NSLayoutConstraint(item: resetButton, attribute: .bottom, relatedBy: .equal, toItem: footerView, attribute: .bottom, multiplier: 1.0, constant: 0.0)
        let leadingConstraint = NSLayoutConstraint(item: resetButton, attribute: .leading, relatedBy: .equal, toItem: closeButton, attribute: .trailing, multiplier: 1.0, constant: 0.0)
        let widthConstraint = NSLayoutConstraint(item: resetButton, attribute: .width, relatedBy: .equal, toItem: closeButton, attribute: .width, multiplier: 1.0, constant: 0.0)
        
        return [topConstraint, trailingConstraint, bottomConstraint, leadingConstraint, widthConstraint]
    }
}
