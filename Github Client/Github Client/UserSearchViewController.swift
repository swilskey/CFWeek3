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
  
  let imageQueue = NSOperationQueue()
  
  var imageCache = [String : UIImage]()
  var users = [User]()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    userCollectionView.dataSource = self
    userSearchBar.delegate = self
    
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
}

extension UserSearchViewController: UICollectionViewDataSource {
  func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return users.count
  }
  
  func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCellWithReuseIdentifier("UserCell", forIndexPath: indexPath) as! UserCollectionCell
    
    let user = users[indexPath.item]
    cell.usernameLabel.text = user.login
    
    cell.tag++
    let tag = cell.tag
    
    cell.userImageView.image = nil
    let imageURL = user.avatarURL
    if let image = imageCache[imageURL] {
      if cell.tag == tag {
        cell.userImageView.image = image
      }
    }
    imageQueue.addOperationWithBlock { () -> Void in
      let userImage = ImageDownloadService.downloadImage(imageURL, size: CGSize(width: 150, height: 150))
      NSOperationQueue.mainQueue().addOperationWithBlock({ () -> Void in
        cell.userImageView.layer.cornerRadius = 60
        cell.userImageView.layer.masksToBounds = true
        self.imageCache[imageURL] = userImage
        if cell.tag == tag {
          cell.userImageView.image = userImage;
        }
        cell.usernameLabel.text = user.login
      })
    }
    
    return cell
  }
}

extension UserSearchViewController: UISearchBarDelegate {
  func searchBarSearchButtonClicked(searchBar: UISearchBar) {
    GithubService.usersForSearchTerm(userSearchBar.text, completionHandler: { (error, data) -> (Void) in
      
      if let error = error {
        println("Error: " + error)
      }
      if let data = data {
        self.users = UserJSONParser.parseUserJSON(data)!
        NSOperationQueue.mainQueue().addOperationWithBlock({ () -> Void in
          self.userSearchBar.resignFirstResponder()
          self.userCollectionView.reloadData()
        })
      }
    })
  }
}