//
//  TabbarController.swift
//  ImageBoard
//
//  Created by JUN LEE on 2017. 8. 1..
//  Copyright © 2017년 LEEJUN. All rights reserved.
//

import UIKit

class TabbarController: UITabBarController {
    
    // MARK: Override
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        if appDelegate.session == nil {
            performSegue(withIdentifier: "segueTabToNavi", sender: self)
        }
    }
}
