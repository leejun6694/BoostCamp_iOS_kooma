//
//  WebViewController.swift
//  WorldTrotter
//
//  Created by JUN LEE on 2017. 7. 4..
//  Copyright © 2017년 LEEJUN. All rights reserved.
//

import UIKit
import WebKit

class WebViewController: UIViewController, UIWebViewDelegate {
    
    @IBOutlet weak var webView: UIWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        webView.delegate = self
        if let url = URL(string: "https://www.bignerdranch.com") {
            let request = URLRequest(url: url)
            webView.loadRequest(request)
        }
    }
}
