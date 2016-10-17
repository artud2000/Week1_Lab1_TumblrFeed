//
//  FeedManager.swift
//  TumblrFeed
//
//  Created by Arturo Fernandez on 10/11/16.
//  Copyright © 2016 Arturo Fernandez. All rights reserved.
//

import Foundation
import UIKit

let REQUEST_MORE_DATA_NOTIFICATION = "requestMoreData"

class FeedManager: NSObject, UITableViewDataSource {
    var photosArray = [TumblrPhotos]()

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return photosArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let tumblrCell: TumblrFeedCell = tableView.dequeueReusableCell(withIdentifier: "tumblrCell", for: indexPath) as! TumblrFeedCell
        
        let photo = photosArray[indexPath.row]
        tumblrCell.imageUrl = photo.url
        tumblrCell.activityIndicator.hidesWhenStopped = true
        tumblrCell.activityIndicator.startAnimating()
        NetworkManager.downloadImageWithURL(url: photo.url) { (data: Data?) in
            if ( photo.url == tumblrCell.imageUrl ) {
                DispatchQueue.main.async {
                    tumblrCell.imageView?.image = UIImage(data: data!)
                    tumblrCell.imageData = data
                    tumblrCell.activityIndicator.stopAnimating()
                    tumblrCell.setNeedsLayout()
                }
            }
        }
        return tumblrCell
    }
    
    @objc(tableView:heightForRowAtIndexPath:) func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100.0
    }
}

extension FeedManager: UITableViewDelegate {
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if ( indexPath.row >= photosArray.count - 1 ) {
            NotificationCenter.default.post(name: NSNotification.Name.init(rawValue: REQUEST_MORE_DATA_NOTIFICATION), object: nil)
        }
    }
}
