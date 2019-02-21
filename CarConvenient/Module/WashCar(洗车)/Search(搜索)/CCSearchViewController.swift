//
//  CCSearchViewController.swift
//  CarConvenient
//
//  Created by Modi on 2019/2/21.
//  Copyright © 2019年 modi. All rights reserved.
//

import UIKit
import TagListView

class CCSearchViewController: BaseViewController {

    @IBOutlet weak var tagListView: TagListView! {
        didSet {
            tagListView.textFont = UIFont.systemFont(ofSize: 12)
            tagListView.textColor = UIColor(rgba: "#333333")
            tagListView.alignment = .left // possible values are .Left, .Center, and .Right
            
            tagListView.addTag("TagListView")
            tagListView.addTags(["Add", "two", "tags"])
            
            tagListView.insertTag("This should be the second tag", at: 1)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    override func setupStyle() {
        super.setupStyle()
        
        let nav = CCSearchNavView.md_viewFromXIB() as! CCSearchNavView
        nav.autoresizingMask = .flexibleWidth
        self.navigationItem.titleView = nav
    }

}
