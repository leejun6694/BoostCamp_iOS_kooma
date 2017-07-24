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
    let headerLabel: UILabel! = UILabel()
    let footerView: UIView! = UIView()
    let tableView: UITableView! = UITableView()
    let closeButton = UIButton()
    let resetButton = UIButton()
    var recordCell: RecordCell! = RecordCell()
    
    let RGBpoint: CGFloat = 255.0
    
    let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        formatter.timeStyle = .medium
        
        return formatter
    }()
    
    // MARK: Draw
    
    func createTableView() {
        self.view.addSubview(tableView)
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 60).isActive = true
        tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -45).isActive = true
    }
    
    func createHeaderLabel() {
        headerLabel.text = "HISTORY"
        headerLabel.textColor = UIColor(red: 111.0/RGBpoint, green: 167.0/RGBpoint, blue: 145.0/RGBpoint, alpha: 1.0)
        headerLabel.textAlignment = .center
        headerLabel.font = UIFont(name: headerLabel.font.fontName, size: 30.0)
        self.view.addSubview(headerLabel)
        
        headerLabel.translatesAutoresizingMaskIntoConstraints = false
        headerLabel.topAnchor.constraint(equalTo: topLayoutGuide.bottomAnchor).isActive = true
        headerLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        headerLabel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        headerLabel.bottomAnchor.constraint(equalTo: self.tableView.topAnchor).isActive = true
        
    }
    
    func createFooterView() {
        self.view.addSubview(footerView)
        
        footerView.translatesAutoresizingMaskIntoConstraints = false
        footerView.topAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -45).isActive = true
        footerView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        footerView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        footerView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        
        createCloseButton()
        createResetButton()        
    }
    
    func createCloseButton() {
        closeButton.setTitle("Close", for: .normal)
        closeButton.setTitleColor(.white, for: .normal)
        closeButton.backgroundColor = UIColor(red: 220.0/RGBpoint, green: 125.0/RGBpoint, blue: 104.0/RGBpoint, alpha: 1.0)
        self.footerView.addSubview(closeButton)
        
        closeButton.translatesAutoresizingMaskIntoConstraints = false
        closeButton.topAnchor.constraint(equalTo: footerView.topAnchor).isActive = true
        closeButton.leadingAnchor.constraint(equalTo: footerView.leadingAnchor).isActive = true
        closeButton.bottomAnchor.constraint(equalTo: footerView.bottomAnchor).isActive = true
        
        closeButton.addTarget(self, action: #selector(clickCloseButton(_:)), for: .touchUpInside)
    }
    
    func createResetButton() {
        resetButton.setTitle("Reset", for: .normal)
        resetButton.setTitleColor(.white, for: .normal)
        resetButton.backgroundColor = UIColor(red: 220.0/RGBpoint, green: 125.0/RGBpoint, blue: 104.0/RGBpoint, alpha: 1.0)
        self.footerView.addSubview(resetButton)
        
        resetButton.translatesAutoresizingMaskIntoConstraints = false
        resetButton.topAnchor.constraint(equalTo: footerView.topAnchor).isActive = true
        resetButton.trailingAnchor.constraint(equalTo: footerView.trailingAnchor).isActive = true
        resetButton.bottomAnchor.constraint(equalTo: footerView.bottomAnchor).isActive = true
        resetButton.leadingAnchor.constraint(equalTo: closeButton.trailingAnchor).isActive = true
        resetButton.widthAnchor.constraint(equalTo: closeButton.widthAnchor).isActive = true
        
        resetButton.addTarget(self, action: #selector(clickResetButton(_:)), for: .touchUpInside)
    }
    
    func updateView() {
        createTableView()
        createHeaderLabel()
        createFooterView()
    }
    
    // MARK: Actions
    
    func clickCloseButton(_ sender: AnyObject) {
        dismiss(animated: true, completion: nil)
    }
    
    func clickResetButton(_ sender: AnyObject) {
        let alertTitle = "REALLY?"
        let alert = UIAlertController(title: alertTitle, message: "", preferredStyle: .alert)
        let noAction = UIAlertAction(title: "NO", style: .cancel, handler: nil)
        alert.addAction(noAction)
        let yesAction = UIAlertAction(title: "YES", style: .destructive, handler: { (action) -> Void in
            self.recordStore.allRecords = []
            self.tableView.reloadData()
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
        
        if recordItem.record < recordStore.maxRecord.record {
            recordStore.maxRecord.record = recordItem.record
            recordStore.maxRecord.name = recordItem.name
            recordStore.maxRecord.dateCreated = recordItem.dateCreated
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let record = recordStore.allRecords[indexPath.row]
            
            recordStore.removeRecord(record: record)
            
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }

    // MARK: override
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateView()
        
        tableView.dataSource = self
        tableView.delegate = self
    
    }
}
