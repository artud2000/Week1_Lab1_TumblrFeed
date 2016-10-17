//
//  NetworkManager.swift
//  TumblrFeed
//
//  Created by Arturo Fernandez on 10/10/16.
//  Copyright © 2016 Arturo Fernandez. All rights reserved.
//

import Foundation


class NetworkManager: NSObject {
    class func retrieveFeedWithEndPoint(endpoint: String, type: String, completionHandler: @escaping (_ data: [TumblrPhotos]?) -> Void) {
        let urlString: String = "\(tumblrURL!)\(endpoint)/posts/\(type)?api_key=\(tumblrKey!)"
        let url: URL = URL(string: urlString)!
        let request: URLRequest = URLRequest(url: url)
        let session: URLSession = URLSession.shared
        
        let task: URLSessionDataTask = session.dataTask(with: request, completionHandler: { (data: Data?, response: URLResponse?, error: Error?) in
            
            if error == nil {
                if let responseDictionary = try! JSONSerialization.jsonObject(with: data!, options: []) as? [String: AnyObject] {
                    let photosResult = fillImagesDictionary(jsonDictionary: responseDictionary)
                    print(photosResult)
                    completionHandler(photosResult)
                  
                }
            } else {
                //completionHandler([String : AnyObject]())
            }
        })
        task.resume()
    }
    
    class func fillImagesDictionary(jsonDictionary: [String: AnyObject]) -> [TumblrPhotos] {
        var resultArray: [TumblrPhotos] = [TumblrPhotos]()
        let arrayOfPosts: [[String: AnyObject]] = jsonDictionary["response"]?["posts"] as! [[String : AnyObject]]
        for post in arrayOfPosts {
            for photoArray in post["photos"] as! [[String: AnyObject]] {
                for photo in photoArray {
                    //print(photo.value)
                    if let photoDictionary = photo.value as? [String: AnyObject] {
                        let tempPhoto = TumblrPhotos(width: photoDictionary["width"] as! Int, height: photoDictionary["height"] as! Int, url: photoDictionary["url"] as! String)
                        resultArray.append(tempPhoto)
                    }
                    
                    //Uncomment if you also want to store alternative Size Images
//                    if let altSizeArray = photo.value as? [[String: AnyObject]] {
//                        for innerPhoto in altSizeArray {
//                            let tempPhoto = TumblrPhotos(width: innerPhoto["width"] as! Int, height: innerPhoto["height"] as! Int, url: innerPhoto["url"] as! String)
//                            resultArray.append(tempPhoto)
//                        }
//                    }
                }
            }
        }
        return resultArray
    }
    
    class func downloadImageWithURL(url: String, completionHandler: @escaping (_ imageData: Data?) -> Void) {
        let url = URL(string: url)
        let request = URLRequest(url: url!)
        let session = URLSession.shared
        
        let task: URLSessionDataTask = session.dataTask(with: request, completionHandler: { (data: Data?, response: URLResponse?, error: Error?) in
            if ( data != nil ) {
                completionHandler(data)
            }
        })
        task.resume()
    }
}
