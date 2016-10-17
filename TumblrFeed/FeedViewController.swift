//
//  FeedViewController.swift
//  TumblrFeed
//
//  Created by Arturo Fernandez on 10/11/16.
//  Copyright © 2016 Arturo Fernandez. All rights reserved.
//

import Foundation
import UIKit

class FeedViewController: UIViewController {
    @IBOutlet var tableView: UITableView!
    @IBOutlet var dataProvider: FeedManager!
    lazy var refreshControl: UIRefreshControl = {
        let tempRefresh = UIRefreshControl()
        tempRefresh.attributedTitle = NSAttributedString(string:"Pull to Refresh")
        tempRefresh.addTarget(self, action: #selector(self.pullDownTriggered(refreshControl:) ), for: UIControlEvents.primaryActionTriggered)
        return tempRefresh
    }()
    
    override func viewDidLoad() {
        NotificationCenter.default.addObserver(self, selector: #selector(self.pullDownTriggered(refreshControl:)), name: NSNotification.Name(rawValue: REQUEST_MORE_DATA_NOTIFICATION), object: nil)
        tableView.delegate = dataProvider
        tableView.dataSource = dataProvider
        tableView.insertSubview(refreshControl, at: 0)
        refreshData()
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let cell: TumblrFeedCell = sender as! TumblrFeedCell
        let vc: DetailViewController = segue.destination as! DetailViewController   
        vc.imageData = cell.imageData
    }
    
    func pullDownTriggered(refreshControl: UIRefreshControl) {
        refreshData()
    }
    
    func refreshData() {
        NetworkManager.retrieveFeedWithEndPoint(endpoint: "humansofnewyork.tumblr.com", type: "photo") { (jsonResponse: [TumblrPhotos]?) in
            print(jsonResponse!)
            DispatchQueue.main.async {
                if self.dataProvider.photosArray.count == 0 {
                    self.dataProvider.photosArray = jsonResponse!
                } else {
                    self.dataProvider.photosArray += jsonResponse!
                }
                self.tableView.reloadData()
                self.refreshControl.endRefreshing()
            }
        }
    }
}
