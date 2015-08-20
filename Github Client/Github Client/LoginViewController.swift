//
//  LoginViewController.swift
//  Github Client
//
//  Created by Sam Wilskey on 8/18/15.
//  Copyright (c) 2015 Wilskey Labs. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    //TODO: Add Observer for token Notification
    NSNotificationCenter.defaultCenter().addObserver(self, selector: "newToken", name: kTokenNotification, object: nil)
  }
  
  override func viewDidAppear(animated: Bool) {
    if let token = KeychainService.loadToken() {
      
    }
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  @IBAction func loginButtonAction(sender: UIButton) {
    NetworkService.requestGithubAccess()
  }
  
  func newToken() {
    performSegueWithIdentifier("PresentMenu", sender: nil)
  }
  
  //TODO: Remove Observer in deinit
  deinit {
    NSNotificationCenter.defaultCenter().removeObserver(self, name: kTokenNotification, object: nil)
  }
  
}
