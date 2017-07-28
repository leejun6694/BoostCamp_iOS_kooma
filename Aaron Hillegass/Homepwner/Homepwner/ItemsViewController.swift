//
//  ItemsViewController.swift
//  Homepwner
//
//  Created by JUN LEE on 2017. 7. 15..
//  Copyright © 2017년 LEEJUN. All rights reserved.
//

import UIKit

class ItemViewController: UITableViewController {
    
    // MARK: Properties
    
    var itemStore: ItemStore!
    var imageStore: ImageStore!
    
    // MARK: Initializer
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        navigationItem.leftBarButtonItem = editButtonItem
    }
    
    // MARK: Functions
    
    @IBAction func addNewItem(sender: AnyObject) {
//        // 0번 섹션, 마지막 행의 인덱스 패스를 만든다
//        let lastRow = tableView.numberOfRows(inSection: 0)
//        let indexPath = NSIndexPath(row: lastRow, section: 0)
//        
//        // 테이블에 새로운 행을 삽입한다
//        tableView.insertRows(at: [indexPath as IndexPath], with: .automatic)
        
        // 새 물품을 만들고 그것을 저장소에 추가한다
        let newItem = itemStore.createItem()
        
        // 배열 안에서 이 항목의 위치를 계산한다
        if let index = itemStore.allItems.index(of: newItem) {
            let indexPath = NSIndexPath(row: index, section: 0)
            
            // 테이블에 새로운 행을 삽입한다
            tableView.insertRows(at: [indexPath as IndexPath], with: .automatic)
        }
    }
    
//    @IBAction func toggleEditingMode(sender: AnyObject) {
//        // 현재 편집 모드이면
//        if isEditing {
//            // 사용자에게 상태를 알리기 위해 버튼의 텍스트를 변경한다
//            sender.setTitle("Edit", for: .normal)
//            
//            // 편집 모드를 끈다
//            setEditing(false, animated: true)
//        }
//        else {
//            // 사용자에게 상태를 알리기 위해 버튼의 텍스트를 변경한다
//            sender.setTitle("Done", for: .normal)
//            
//            // 편집 모드로 들어간다
//            setEditing(true, animated: true)
//        }
//    }
    
    // MARK: Override
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemStore.allItems.count + 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        // 기본 모양을 가진 UITableViewCell 인스턴스를 만든다
//        let cell = UITableViewCell(style: .value1, reuseIdentifier: "UITableViewCell")
        
        // 재사용 셀이나 새로운 셀을 얻는다
//        let cell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell", for: indexPath)
        let cell = tableView.dequeueReusableCell(withIdentifier: "ItemCell", for: indexPath) as! ItemCell
        
        // 선호하는 텍스트 크기로 라벨을 업데이트한다
        cell.updateLabels()
        
        // 물품 배열의 n번째 있는 항목의 설명을 n과 row와 일치하는 셀의 텍스트로 설정한다
        // 이셀은 테이블 뷰의 n 번째 행에 나타난다
        if indexPath.row < itemStore.allItems.count {
            let item = itemStore.allItems[indexPath.row]
            
//            cell.textLabel?.text = item.name
//            cell.detailTextLabel?.text = "$\(item.valueInDollars)"
//            c
//            cell.textLabel?.font = cell.textLabel?.font.withSize(20)
//            cell.detailTextLabel?.font = cell.detailTextLabel?.font.withSize(20)
            
            cell.nameLabel.text = item.name
            cell.serialNumberLabel.text = item.serialNumber
            cell.valueLabel.text = "$\(item.valueInDollars)"
            
            if item.valueInDollars < 50 {
                cell.valueLabel.textColor = .green
            }
            else {
                cell.valueLabel.textColor = .red
            }
        }
        // 마지막 cell
        else {
//            cell.textLabel?.text = "No more items!"
//            cell.detailTextLabel?.text = ""
            
            cell.nameLabel.text = "No more items!"
            cell.serialNumberLabel.text = ""
            cell.valueLabel.text = ""
        }
        
        cell.backgroundColor = .clear
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        return "Remove"
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        // 테이블 뷰가 삭제 명령의 적용을 요청하면
        if editingStyle == .delete {
            let item = itemStore.allItems[indexPath.row]
            
            let title = "Delete \(item.name)?"
            let message = "Are you sure you want to delete this item?"
            
            let ac = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
            
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            ac.addAction(cancelAction)
            
            let deleteAction = UIAlertAction(title: "Remove", style: .destructive, handler: { [unowned self, tableView] (action) -> Void in
                // 저장소에서 그 항목을 제거한다
                self.itemStore.removeItem(item: item)
                
                // 이미지 저장소에서 item의 이미지를 제거한다
                self.imageStore.deleteImageForKey(key: item.itemKey)
                
                // 또한 애니메이션과 함께 테이블 뷰에서 그 행을 제거한다
//                self.tableView.deleteRows(at: [indexPath], with: .automatic)
                tableView.deleteRows(at: [indexPath], with: .automatic)
            })
            ac.addAction(deleteAction)
            
            present(ac, animated: true, completion: nil)
        }
    }
    
    // 특정 cell 재정렬 막기
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
//        if indexPath.row < itemStore.allItems.count {
//            return true
//        }
//        else {
//            return false
//        }
        
        return indexPath.row < itemStore.allItems.count
    }
    
    // 특정 cell delete 막기
    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle {
        if indexPath.row == itemStore.allItems.count {
            return UITableViewCellEditingStyle.none
        }
        else {
            return UITableViewCellEditingStyle.delete
        }
    }
    
    // 특정 cell로 재정렬 막기
    override func tableView(_ tableView: UITableView, targetIndexPathForMoveFromRowAt sourceIndexPath: IndexPath, toProposedIndexPath proposedDestinationIndexPath: IndexPath) -> IndexPath {
        if proposedDestinationIndexPath.row == itemStore.allItems.count {
            return sourceIndexPath
        }
        else {
            return proposedDestinationIndexPath
        }
    }
    
    // cell 높이 변경
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row < itemStore.allItems.count {
            return 60
        }
        else {
            return 44
        }
    }
    
    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        itemStore.moveItemAtIndex(fromIndex: sourceIndexPath.row, toIndex: destinationIndexPath.row)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        // 상태 바의 높이를 얻는다
//        let statusBarHeight = UIApplication.shared.statusBarFrame.height
//        
//        let insets = UIEdgeInsets(top: statusBarHeight, left: 0, bottom: 0, right: 0)
//        tableView.contentInset = insets
//        tableView.scrollIndicatorInsets = insets
        
        let backView = UIImageView(image: #imageLiteral(resourceName: "pastel"))
        self.tableView.backgroundView = backView
        
//        tableView.rowHeight = 65
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 65
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // 발생한 세그웨이가 "ShowItem" 세그웨이 이면
        if segue.identifier == "ShowItem" {
            
            // 방금 어느 행이 눌렸는지 계산한다
            if let row = tableView.indexPathForSelectedRow?.row {
                
                // 이 행에연결된 Item을 가져와서 전달한다
                let item = itemStore.allItems[row]
                let detailViewController = segue.destination as! DetailViewController
                detailViewController.item = item
                detailViewController.imageStore = imageStore
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tableView.reloadData()
    }
}
