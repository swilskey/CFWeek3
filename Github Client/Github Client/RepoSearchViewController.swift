//
//  RepoSearchViewController.swift
//  Github Client
//
//  Created by Sam Wilskey on 8/17/15.
//  Copyright (c) 2015 Wilskey Labs. All rights reserved.
//

import UIKit

class RepoSearchViewController: UIViewController {
  @IBOutlet weak var repoTableView: UITableView!
  @IBOutlet weak var repoSearchBar: UISearchBar!
  @IBOutlet weak var activityMonitor: UIActivityIndicatorView!
  
  var repositories = [Repo]()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    repoTableView.dataSource = self
    repoSearchBar.delegate = self
    
    repoTableView.estimatedRowHeight = 85
    repoTableView.rowHeight = UITableViewAutomaticDimension
    
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  // MARK: - Navigation
  
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    if segue.identifier == "ShowRepo" {
      let destination = segue.destinationViewController as! RepositoryViewController
      
      let selectedRepository = repoTableView.indexPathForSelectedRow()?.row
      destination.repository = repositories[selectedRepository!]
    }
  }

}

extension RepoSearchViewController: UISearchBarDelegate {
  func searchBarSearchButtonClicked(searchBar: UISearchBar) {
    activityMonitor.startAnimating()
    GithubService.repositoriesForSearchTerm(repoSearchBar.text, completionHandler: { (error, data) -> (Void) in
      
      if let error = error {
        println(error)
      }
      if let data = data {
        self.repositories = RepositoryJSONParser.parseRepository(data)!
        NSOperationQueue.mainQueue().addOperationWithBlock({ () -> Void in
          self.activityMonitor.stopAnimating()
          self.repoSearchBar.resignFirstResponder()
          self.repoTableView.reloadData()
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

extension RepoSearchViewController: UITableViewDataSource {
  
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return self.repositories.count
  }
  
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCellWithIdentifier("RepositoryCell", forIndexPath: indexPath) as! RepoCell
    cell.repoNameLabel.text = self.repositories[indexPath.row].fullName
    cell.repoDescriptionLabel.text = self.repositories[indexPath.row].description
    
    return cell
  }
}