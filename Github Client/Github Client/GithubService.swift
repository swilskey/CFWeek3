//
// Created by Sam Wilskey on 8/17/15.
// Copyright (c) 2015 Wilskey Labs. All rights reserved.
//

import Foundation

class GithubService {
  
  class func repositoriesForSearchTerm(searchTerm: String, completionHandler: (error: String?, data: NSData?) -> (Void)) {
    let token = "token " + String(KeychainService.loadToken()!)
    let baseURL = "https://api.github.com/search/repositories"
    let finalURL = baseURL + "?q=\(searchTerm)"
    let request = NSMutableURLRequest(URL: NSURL(string: finalURL)!)
    request.setValue(token, forHTTPHeaderField: "Authorization");
    
    NSURLSession.sharedSession().dataTaskWithRequest(request, completionHandler: { (data, response, error) -> Void in
      if let error = error {
        println(error)
      } else if let httpResponse = response as? NSHTTPURLResponse {
        switch httpResponse.statusCode {
        case 200...299:
          completionHandler(error: nil, data: data)
        case 300...399:
          completionHandler(error: "300 error", data: nil)
        default:
          completionHandler(error: "Unknown Error", data: nil)
        }
      }
    }).resume()
  }
  
  class func usersForSearchTerm(searchTerm: String, completionHandler: (error: String?, data: NSData?) -> (Void)) {
    let token = "token " + String(KeychainService.loadToken()!)
    let baseURL = "https://api.github.com/search/users"
    let finalURL = baseURL + "?q=\(searchTerm)"
    
    let request = NSMutableURLRequest(URL: NSURL(string: finalURL)!)
    request.setValue(token, forHTTPHeaderField: "Authorization")
    
    NSURLSession.sharedSession().dataTaskWithRequest(request, completionHandler: { (data, response, error) -> Void in
      if let error = error {
        println("Github Service Error")
        println(error)
      } else if let httpResponse = response as? NSHTTPURLResponse {
        switch httpResponse.statusCode {
        case 200...299:
          completionHandler(error: nil, data: data)
        case 300...399:
          completionHandler(error: "300 error", data: nil)
        default:
          completionHandler(error: "Unknown Error", data: nil)
        }

      }
    }).resume()
  }
}