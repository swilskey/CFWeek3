//
//  UserSearchViewController.swift
//  Github Client
//
//  Created by Sam Wilskey on 8/18/15.
//  Copyright (c) 2015 Wilskey Labs. All rights reserved.
//

import UIKit

class UserSearchViewController: UIViewController {
  
  @IBOutlet weak var userSearchBar: UISearchBar!
  @IBOutlet weak var userCollectionView: UICollectionView!
  
  let transition = UserTransitionController()
  let imageQueue = NSOperationQueue()
  var users = [User]()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    userCollectionView.dataSource = self
    userSearchBar.delegate = self
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
  
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    let destination = segue.destinationViewController as! UserViewController
    let indexPath = userCollectionView.indexPathsForSelectedItems().first as! NSIndexPath
    destination.user = users[indexPath.item]
    destination.userCellIndex = indexPath
  }
}

// MARK: - UICollectionViewDataSource

extension UserSearchViewController: UICollectionViewDataSource {
  func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return users.count
  }
  
  func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCellWithReuseIdentifier("UserCell", forIndexPath: indexPath) as! UserCollectionCell
    cell.alpha = 0
    let user = users[indexPath.item]
    cell.usernameLabel.text = user.login
    
    cell.tag++
    let tag = cell.tag
    
    cell.userImageView.image = nil
    let imageURL = user.avatarURL
    if let image = ImageCacheService.sharedCache.getImage(imageURL) {
      if cell.tag == tag {
        cell.userImageView.layer.cornerRadius = 60
        cell.userImageView.layer.masksToBounds = true
        cell.userImageView.image = image
        
        UIView.animateWithDuration(0.3, animations: { () -> Void in
          cell.alpha = 1
        })
      }
    }
    imageQueue.addOperationWithBlock { () -> Void in
      let userImage = ImageDownloadService.downloadImage(imageURL, size: CGSize(width: 150, height: 150))
      NSOperationQueue.mainQueue().addOperationWithBlock({ () -> Void in
        cell.userImageView.layer.cornerRadius = 60
        cell.userImageView.layer.masksToBounds = true
        ImageCacheService.sharedCache.addImage(imageURL, image: userImage!)
        if cell.tag == tag {
          
          cell.userImageView.image = userImage;
          cell.usernameLabel.text = user.login
          UIView.animateWithDuration(0.3, animations: { () -> Void in
            cell.alpha = 1
          })
        }
      })
    }
    
    return cell
  }
}

// MARK: - UISearchBarDelagete

extension UserSearchViewController: UISearchBarDelegate {
  func searchBarSearchButtonClicked(searchBar: UISearchBar) {
    GithubService.usersForSearchTerm(userSearchBar.text, completionHandler: { (error, data) -> (Void) in
      
      if let error = error {
        println("Error: " + error)
      }
      if let data = data {
        self.users = UserJSONParser.parseUserSearchJSON(data)!
        NSOperationQueue.mainQueue().addOperationWithBlock({ () -> Void in
          self.userSearchBar.resignFirstResponder()
          self.userCollectionView.reloadData()
        })
      }
    })
  }
  
  func searchBar(searchBar: UISearchBar, shouldChangeTextInRange range: NSRange, replacementText text: String) -> Bool {
    if !text.validateForURL() {
      searchBar.barTintColor = UIColor.redColor()
      return text.validateForURL()
    }
    searchBar.barTintColor = nil
    return text.validateForURL()
  }
}

// MARK: - UIViewControllerTransitioningDelagete

extension UserSearchViewController: UINavigationControllerDelegate {
  func navigationController(navigationController: UINavigationController, animationControllerForOperation operation: UINavigationControllerOperation, fromViewController fromVC: UIViewController, toViewController toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
    
    return toVC is UserViewController ? UserTransitionController() : nil
  }
}