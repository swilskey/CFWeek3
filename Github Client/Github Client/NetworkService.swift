//
//  NetworkService.swift
//  Github Client
//
//  Created by Sam Wilskey on 8/18/15.
//  Copyright (c) 2015 Wilskey Labs. All rights reserved.
//

import UIKit

class NetworkService {
  static let sharedService = NetworkService()
  
  private init() {}
  
  class func requestGithubAccess() {
    let authURL = NSURL(string: "https://github.com/login/oauth/authorize?client_id=\(Keys.kClientId.rawValue)&redirect_uri=githubclient://oauth&scope=user,repo")
    UIApplication.sharedApplication().openURL(authURL!)
  }
  
  class func requestAccessToken() {
    
  }
  
  class func exchangeCodeInURL(codeURL : NSURL) {
    if let code = codeURL.query {
      let request = NSMutableURLRequest(URL: NSURL(string: "https://github.com/login/oauth/access_token?\(code)&client_id=\(Keys.kClientId.rawValue)&client_secret=\(Keys.kClientSecret.rawValue)")!)
      println(request.URL)
      request.HTTPMethod = "POST"
      request.setValue("application/json", forHTTPHeaderField: "Accept")
      NSURLSession.sharedSession().dataTaskWithRequest(request, completionHandler: { (data, response, error) -> Void in
        if let httpResponse = response as? NSHTTPURLResponse {
          
          var jsonError: NSError?
          if let rootObject = NSJSONSerialization.JSONObjectWithData(data, options: nil, error: &jsonError) as? [String : AnyObject],
            token = rootObject["access_token"] as? String {
              KeychainService.saveToken(token)
          }
        }
      }).resume()
    }
  }
}