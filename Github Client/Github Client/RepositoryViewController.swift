//
//  RepositoryViewController.swift
//  Github Client
//
//  Created by Sam Wilskey on 8/19/15.
//  Copyright (c) 2015 Wilskey Labs. All rights reserved.
//

import UIKit
import WebKit

class RepositoryViewController: UIViewController {
  @IBOutlet weak var webViewContainer: UIView!
  var repository: Repo?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    let webView = WKWebView(frame: view.frame)
    webViewContainer.addSubview(webView)
    let url = NSURL(string: repository!.url)
    let request = NSURLRequest(URL: url!)
    
    webView.loadRequest(request)
    // Do any additional setup after loading the view.
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
}
