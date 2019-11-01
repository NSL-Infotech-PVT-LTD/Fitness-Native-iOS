//
//  AthleteDashbEventsVC.swift
//  UTrain
//
//  Created by osx on 24/10/19.
//  Copyright © 2019 osx. All rights reserved.
//

import UIKit

class AthleteDashbEventsVC: UIViewController {

    @IBOutlet weak var eventsTblView: UITableView?
    
    //MARK:- View Life-Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        eventsTblView?.delegate   = self
        eventsTblView?.dataSource = self

    }
    
    class func instance()->AthleteDashbEventsVC?{
        let storyboard = UIStoryboard(name: "AthleteDashboard", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "AthleteDashbEventsVC") as? AthleteDashbEventsVC
        return controller
    }

}
extension AthleteDashbEventsVC: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "eventsCell", for: indexPath) as? AthleteDashbEventsCell else{
            return UITableViewCell()
        }
        cell.eventsImgView?.image = UIImage(named: "gps")
        cell.eventsImgContainer?.rounded()
        
        return cell
    }
    
    
}
