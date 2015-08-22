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
  @IBOutlet weak var repositoryCountLabel: UILabel!
  @IBOutlet weak var followerCountLabel: UILabel!
  
  var user: User?
  var userProfile: UserProfile?
  var userRepos = [Repo]()
  var userCellIndex: NSIndexPath?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    if let userURL = user?.url {
      GithubService.userWithLogin(userURL, completionHandler: { (error, data) -> (Void) in
        if let error = error {
          println(error)
        }
        if let data = data {
          self.userProfile = UserJSONParser.parseUserProfileJSON(data)
          NSOperationQueue.mainQueue().addOperationWithBlock({ () -> Void in
            self.usernameLabel.text = self.userProfile?.name
            self.followerCountLabel.text = String(stringInterpolationSegment: self.userProfile?.followers)
            self.repositoryCountLabel.text = String(stringInterpolationSegment: self.userProfile?.publicRepos)
          })
        }
      })
    }
    
    userImageView.layer.cornerRadius = 150
    userImageView.layer.masksToBounds = true
    // Do any additional setup after loading the view.
  }
  
  override func viewWillAppear(animated: Bool) {
    super.viewWillAppear(animated)
    navigationController?.delegate = self
  }
  
  override func viewWillDisappear(animated: Bool) {
    super.viewWillDisappear(animated)
    navigationController?.delegate = nil
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
}

extension UserViewController: UINavigationControllerDelegate {
  func navigationController(navigationController: UINavigationController, animationControllerForOperation operation: UINavigationControllerOperation, fromViewController fromVC: UIViewController, toViewController toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
    
    return toVC is UserSearchViewController ? UserReverseTransitionController(): nil
  }
}

extension UserViewController: UITableViewDataSource {
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return userRepos.count
  }
  
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCellWithIdentifier("RepoCell", forIndexPath: indexPath) as! RepoCell
    cell.repoNameLabel.text = userRepos[indexPath.row].name
    cell.repoDescriptionLabel.text = userRepos[indexPath.row].description
    return cell
  }
}