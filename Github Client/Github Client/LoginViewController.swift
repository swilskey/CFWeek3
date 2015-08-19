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

        // Do any additional setup after loading the view.
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
