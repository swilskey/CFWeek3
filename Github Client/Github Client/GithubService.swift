//
// Created by Sam Wilskey on 8/17/15.
// Copyright (c) 2015 Wilskey Labs. All rights reserved.
//

import Foundation

class GithubService {
  
  class func repositoriesForSearchTerm(searchTerm: String, completionHandler: (error: String?, data: NSData?) -> (Void)) {
    let token = getToken()
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
  
  class func repositoriesForUser(userRepoURL: String, completionHandler: (error: String?, data: NSData?) -> (Void)) {
    let token = getToken()
    
    let request = NSMutableURLRequest(URL: NSURL(string: userRepoURL)!)
    request.setValue(token, forHTTPHeaderField: "Authorization")
    
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
    let token = getToken()
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
  
  class func userWithLogin(userURL: String, completionHandler: (error: String?, data: NSData?) -> (Void)) {
    let token = getToken()
    let request = NSMutableURLRequest(URL: NSURL(string: userURL)!)
    request.setValue(token, forHTTPHeaderField: "Authorization")
    
    NSURLSession.sharedSession().dataTaskWithRequest(request, completionHandler: { (data, response, error) -> Void in
      if let error = error {
        println(error)
      } else if let httpResponse = response as? NSHTTPURLResponse {
        switch httpResponse.statusCode {
        case 200...299:
          completionHandler(error: nil, data: data)
        case 300...399:
          completionHandler(error: "300 Error", data: nil)
        default:
          completionHandler(error: "Unknown Error", data: nil)
        }
      }
    }).resume()
  }
  
  class func userWithLogin(completionHandler: (error: String?, data: NSData?) -> (Void)) {
    let token = getToken()
    let url = "https://api.github.com/user"
    let request = NSMutableURLRequest(URL: NSURL(string: url)!)
    request.setValue(token, forHTTPHeaderField: "Authorization")
    
    NSURLSession.sharedSession().dataTaskWithRequest(request, completionHandler: { (data, response, error) -> Void in
      if let error = error {
        println(error)
      } else if let httpResponse = response as? NSHTTPURLResponse {
        switch httpResponse.statusCode {
        case 200...299:
          completionHandler(error: nil, data: data)
        case 300...399:
          completionHandler(error: "300 Error", data: nil)
        default:
          completionHandler(error: "Unknown Error", data: nil)
        }
      }
    }).resume()
  }
  
  private class func getToken() -> String {
    return "token " + String(KeychainService.loadToken()!)
  }
}