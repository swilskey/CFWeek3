//
//  UserProfileViewController.swift
//  Github Client
//
//  Created by Sam Wilskey on 8/22/15.
//  Copyright (c) 2015 Wilskey Labs. All rights reserved.
//

import UIKit

class UserProfileViewController: UIViewController {
  @IBOutlet weak var userImageView: UIImageView!
  @IBOutlet weak var userDetailView: UIView!
  @IBOutlet weak var usernameLabel: UILabel!
  
  let imageQueue = NSOperationQueue()
  
  var userProfile: UserProfile?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    userImageView.alpha = 0
    usernameLabel.alpha = 0
    userDetailView.layer.cornerRadius = 25
    userImageView.layer.cornerRadius = 100
    userImageView.layer.masksToBounds = true
    
    GithubService.userWithLogin { (error, data) -> (Void) in
      if let error = error {
        
      } else if let data = data {
        if let user = UserJSONParser.parseUserProfileJSON(data) {
          self.userProfile = user
          self.imageQueue.addOperationWithBlock({ () -> Void in
            let image = ImageDownloadService.downloadImage(user.avatarURL, size: CGSize(width: 400, height: 400))
            NSOperationQueue.mainQueue().addOperationWithBlock({ () -> Void in
              self.usernameLabel.text = self.userProfile?.name
              self.userImageView.image = image
              UIView.animateWithDuration(0.3, animations: { () -> Void in
                self.usernameLabel.alpha = 1
                self.userImageView.alpha = 1
              })
            })
          })
          
        }
      }
    }
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()

  }
  
}
