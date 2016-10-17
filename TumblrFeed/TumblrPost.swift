//
//  TumblrPost.swift
//  TumblrFeed
//
//  Created by Arturo Fernandez on 10/14/16.
//  Copyright © 2016 Arturo Fernandez. All rights reserved.
//

import Foundation


struct TumblrPost {
    var photos: [TumblrPhotos]
    var postDescription: String
    var blogName: String
    
    init(photos: [TumblrPhotos] = [TumblrPhotos](), postDescription: String = "", blogName: String = "") {
        self.photos = photos
        self.postDescription = postDescription
        self.blogName = blogName
    }
}
