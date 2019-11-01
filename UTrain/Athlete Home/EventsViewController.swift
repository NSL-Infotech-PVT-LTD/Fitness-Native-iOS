//
//  EventsViewController.swift
//  UTrain
//
//  Created by osx on 27/09/19.
//  Copyright © 2019 osx. All rights reserved.
//

import UIKit

class EventsViewController: UIViewController {
    //MARK:- Outlets and Variables
    @IBOutlet weak var tbl_view: UITableView?
    
    //MARK:- View Life-Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        tbl_view?.delegate   = self
        tbl_view?.dataSource = self
        tbl_view?.contentInset = UIEdgeInsets(top: 20.0, left: 0, bottom: 0, right: 0)
    }
    

    class func instance()->EventsViewController?{
        let storyboard = UIStoryboard(name: "AthleteHomeScreen", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "EventsViewController") as? EventsViewController
        return controller
    }

}

extension EventsViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tbl_view?.dequeueReusableCell(withIdentifier: "EventsTableCell", for: indexPath) as? EventsTableCell else{
            return UITableViewCell()
        }
        
        return cell
    }
    
    
}
