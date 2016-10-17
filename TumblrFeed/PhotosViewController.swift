//
//  ViewController.swift
//  TumblrFeed
//
//  Created by Arturo Fernandez on 10/10/16.
//  Copyright © 2016 Arturo Fernandez. All rights reserved.
//

import UIKit

let tumblrKey: String! = "Q6vHoaVm5L1u2ZAW1fqv3Jw48gFzYVg9P0vH0VHl3GVy6quoGV"
let tumblrURL: URL! = URL(string:"https://api.tumblr.com/v2/blog/") 

class PhotosViewController: UIViewController {
    lazy var feedViewController: FeedViewController = {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        return storyboard.instantiateViewController(withIdentifier: "FeedViewController") as! FeedViewController
    }()
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.addChildViewController(feedViewController)
        feedViewController.didMove(toParentViewController: self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        view.addSubviewInContainerView(subView: feedViewController.view)
        self.title = "Home Feed"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


}

