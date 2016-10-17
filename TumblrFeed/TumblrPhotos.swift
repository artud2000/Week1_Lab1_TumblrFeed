//
//  TumblrPhotos.swift
//  TumblrFeed
//
//  Created by Arturo Fernandez on 10/14/16.
//  Copyright © 2016 Arturo Fernandez. All rights reserved.
//

import Foundation


struct TumblrPhotos {
    var width: Int
    var height: Int
    var url: String
    init(width: Int, height: Int, url: String) {
        self.width = width
        self.height = height
        self.url = url
    }
}
