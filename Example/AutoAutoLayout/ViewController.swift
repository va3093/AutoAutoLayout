//
//  ViewController.swift
//  AutoAutoLayout
//
//  Created by Wilhelm on 01/07/2016.
//  Copyright (c) 2016 Wilhelm. All rights reserved.
//

import UIKit
import AutoAutoLayout

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    lazy private(set) var tableView: UITableView = {
       let tableView = UITableView.withAutoLayout()
        tableView.delegate = self
        tableView.dataSource = self
        
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.whiteColor()
        
        self.view.addSubview(self.tableView)
        self.tableView.addCustomConstraints(inView: self.view, selfAttributes: [.Top, .Leading, .Trailing, .Bottom])
    }
    
    //MARK: UITableViewDelegate
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        switch indexPath.row {
        case 0:
            self.navigationController?.pushViewController(VerticalStackingViewController(), animated: true)
            tableView.deselectRowAtIndexPath(indexPath, animated: true)
        default:
            break;
        }
    }
    
    //MARK: UITableViewDataSource
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCellWithIdentifier("Identifier") {
            
            return cell
        } else {
            let cell = UITableViewCell()
            cell.textLabel?.text = "Vertical Stacking"
            return cell
        }
    }
   

}

