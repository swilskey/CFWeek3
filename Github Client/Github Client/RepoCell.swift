//
//  RepoCell.swift
//  Github Client
//
//  Created by Sam Wilskey on 8/19/15.
//  Copyright (c) 2015 Wilskey Labs. All rights reserved.
//

import UIKit

class RepoCell: UITableViewCell {
  @IBOutlet weak var repoNameLabel: UILabel!
  @IBOutlet weak var repoDescriptionLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
