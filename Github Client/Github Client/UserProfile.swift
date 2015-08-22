//
//  UserProfile.swift
//  Github Client
//
//  Created by Sam Wilskey on 8/21/15.
//  Copyright (c) 2015 Wilskey Labs. All rights reserved.
//

import Foundation

struct UserProfile {
  let login: String
  let name: String
  let id: Int
  let avatarURL: String
  let htmlURL: String
  let reposURL: String
  let company: String?
  let followers: Int
  let following: Int
  let publicRepos: Int
}