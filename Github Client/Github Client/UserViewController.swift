//
//  UserViewController.swift
//  Github Client
//
//  Created by Sam Wilskey on 8/19/15.
//  Copyright (c) 2015 Wilskey Labs. All rights reserved.
//

import UIKit

class UserViewController: UIViewController {
  @IBOutlet weak var userImageView: UIImageView!
  @IBOutlet weak var usernameLabel: UILabel!
  
  var user: User?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    userImageView.layer.cornerRadius = 150
    userImageView.layer.masksToBounds = true
    usernameLabel.text = user?.login
    // Do any additional setup after loading the view.
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
}
