//
//  UserJSONParser.swift
//  Github Client
//
//  Created by Sam Wilskey on 8/17/15.
//  Copyright (c) 2015 Wilskey Labs. All rights reserved.
//

import Foundation

class UserJSONParser {
  
  class func parseUserJSON(jsonData: NSData) -> [User]? {
    var error: NSError?
    var retUsers = [User]()
    
    if let rootData = NSJSONSerialization.JSONObjectWithData(jsonData, options: nil, error: &error) as? [String : AnyObject],
      users = rootData["items"] as? [[String : AnyObject]] {
        for user in users {
          if let id = user["id"] as? Int,
          login = user["login"] as? String,
          avatarURL = user["avatar_url"] as? String,
          url = user["html_url"] as? String {
            let retUser = User(login: login, id: String(id), avatarURL: avatarURL, url: url)
            retUsers.append(retUser)
          }
        }
        return retUsers
    }
    
    return nil
  }
}