//
//  Home.swift
//  DemoSocialApp
//
//  Created by Manisha Wadekar on 6/19/20.
//  Copyright © 2020 Manisha Wadekar. All rights reserved.
//

import UIKit

class Home: UIViewController {

    // MARK: - Declaration
    @IBOutlet fileprivate weak var tblFeeds:UITableView!
    
    
    var arrFeeds:[String] = []
    // MARK: -
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
}

extension Home: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5 //arrFeeds.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "idHomeCell") as! HomeTableViewCell
        return cell
    }
}

extension Home: UITableViewDelegate {
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath){
        if let homeCell = cell as? HomeTableViewCell {
            if indexPath.row % 2 == 0 {
                homeCell.lcMediaHeight.constant = 150
            }
            else {
                homeCell.lcMediaHeight.constant = 0
            }
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row % 2 == 0 {
            return 335
        }
        else {
            return 185
        }
    }
}
