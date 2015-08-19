//
//  RepositoryJSONParser.swift
//  Github Client
//
//  Created by Sam Wilskey on 8/17/15.
//  Copyright (c) 2015 Wilskey Labs. All rights reserved.
//

import Foundation

class RepositoryJSONParser {
  
  class func parseRepository(jsonData: NSData) -> [Repo]? {
    var error: NSError?
    
    var repos = [Repo]()
    
    if let rootData = NSJSONSerialization.JSONObjectWithData(jsonData, options: nil, error: &error) as? [String: AnyObject],
      repositories = rootData["items"] as? [[String: AnyObject]] {
        for repository in repositories {
          if let id = repository["id"] as? Int,
            name = repository["name"] as? String,
            fullName = repository["full_name"] as? String,
            url = repository["html_url"] as? String,
            description = repository["description"] as? String,
            language = repository["language"] as? String {
              let strId = String(id)
              let repo = Repo(id: strId, name: name, fullName: fullName, url: url, description: description, language: language)
              repos.append(repo)
          }
        }
        return repos
    }
    return nil
  }
}