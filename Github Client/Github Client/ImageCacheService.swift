//
//  ImageCacheService.swift
//  Github Client
//
//  Created by Sam Wilskey on 8/20/15.
//  Copyright (c) 2015 Wilskey Labs. All rights reserved.
//

import UIKit

class ImageCacheService {
  
  static let sharedCache = ImageCacheService()
  
  private init() {}
  
  var cache = [String : UIImage]()
  
  func addImage(key: String, image: UIImage) {
    cache[key] = image
  }
  
  func getImage(key: String) -> UIImage? {
    if let image = cache[key] {
      return image
    }
    return nil
  }
}