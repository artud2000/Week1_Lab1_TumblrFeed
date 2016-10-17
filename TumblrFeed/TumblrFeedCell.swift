//
//  TumblrFeedCell.swift
//  TumblrFeed
//
//  Created by Arturo Fernandez on 10/11/16.
//  Copyright © 2016 Arturo Fernandez. All rights reserved.
//

import Foundation
import UIKit

class TumblrFeedCell: UITableViewCell {
    @IBOutlet weak var tumblrCellImageView: UIImageView!
    @IBOutlet weak var tumblrCellTitle: UILabel!
    @IBOutlet weak var tumblrCellDescription: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    var imageUrl: String!
    var imageData: Data!
}
