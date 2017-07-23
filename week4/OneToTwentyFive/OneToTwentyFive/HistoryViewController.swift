//
//  HistoryViewController.swift
//  OneToTwentyFive
//
//  Created by JUN LEE on 2017. 7. 23..
//  Copyright © 2017년 LEEJUN. All rights reserved.
//

import UIKit

class HistoryViewController: UITableViewController {
    
    // MARK: Properties

    var recordStore: RecordStore!
    
    // MARK: Actions
    
    func clickCloseButton(_ sender: AnyObject) {
        dismiss(animated: true, completion: nil)
    }
    
    // MARK: override
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let statusBarHeight = UIApplication.shared.statusBarFrame.height
        
        let insets = UIEdgeInsets(top: statusBarHeight, left: 0, bottom: 0, right: 0)
        tableView.contentInset = insets
        tableView.scrollIndicatorInsets = insets
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recordStore.allRecords.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
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
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
}
