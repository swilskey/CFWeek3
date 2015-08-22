//
//  UserJSONParser.swift
//  Github Client
//
//  Created by Sam Wilskey on 8/17/15.
//  Copyright (c) 2015 Wilskey Labs. All rights reserved.
//

import Foundation

class UserJSONParser {
  
  class func parseUserSearchJSON(jsonData: NSData) -> [User]? {
    var error: NSError?
    var retUsers = [User]()
    
    if let rootData = NSJSONSerialization.JSONObjectWithData(jsonData, options: nil, error: &error) as? [String : AnyObject],
      users = rootData["items"] as? [[String : AnyObject]] {
        for user in users {
          if let id = user["id"] as? Int,
          login = user["login"] as? String,
          avatarURL = user["avatar_url"] as? String,
          url = user["url"] as? String {
            let retUser = User(login: login, id: String(id), avatarURL: avatarURL, url: url)
            retUsers.append(retUser)
          }
        }
        return retUsers
    }
    
    return nil
  }
  
  class func parseUserProfileJSON(jsonData: NSData) -> UserProfile? {
    var error: NSError?
    
    if let rootData = NSJSONSerialization.JSONObjectWithData(jsonData, options: nil, error: &error) as? [String : AnyObject],
    login = rootData["login"] as? String,
    name = rootData["name"] as? String,
    id = rootData["id"] as? Int,
    avatarURL = rootData["avatar_url"] as? String,
    htmlURL = rootData["html_url"] as? String,
    repoURL = rootData["repos_url"] as? String,
    followers = rootData["followers"] as? Int,
    following = rootData["following"] as? Int,
    publicRepos = rootData["public_repos"] as? Int {
      if let company = rootData["company"] as? String {
        let userProfile = UserProfile(login: login, name: name, id: id, avatarURL: avatarURL, htmlURL: htmlURL, reposURL: repoURL, company: company, followers: followers, following: following, publicRepos: publicRepos)
        return userProfile
        
      }
      let userProfile = UserProfile(login: login, name: name, id: id, avatarURL: avatarURL, htmlURL: htmlURL, reposURL: repoURL, company: nil, followers: followers, following: following, publicRepos: publicRepos)
      return userProfile
    }
    return nil
  }
}