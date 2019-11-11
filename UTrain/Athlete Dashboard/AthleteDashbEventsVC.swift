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
    var datasource = [AthleteEventListModel]()
    
    //MARK:- View Life-Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        eventsTblView?.delegate   = self
        eventsTblView?.dataSource = self
        getEventListForAthlete()

    }
    
    class func instance()->AthleteDashbEventsVC?{
        let storyboard = UIStoryboard(name: "AthleteDashboard", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "AthleteDashbEventsVC") as? AthleteDashbEventsVC
        return controller
    }
    
    func getEventListForAthlete(){
        api.delegate = self
        var params = [String:Any]()
        params = ["search": "",
                  "limit":  "1",
                  "order_by": "distance",
                  "radius": "10"]
        
        showIndicator()
        api.getEventListForAthlete(url: API_ENDPOINTS.EVENT_LIST_ATHLETE.rawValue, params: params, viewController: self) { (model) in
            if model != nil{
                self.datasource = model
                self.eventsTblView?.reloadData()
            }
        }
    }

}


extension AthleteDashbEventsVC: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return datasource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "eventsCell", for: indexPath) as? AthleteDashbEventsCell else{
            return UITableViewCell()
        }
        
       // let imagePath = datasource[indexPath.row].images?[0]
        //let url = URL(string: API_ENDPOINTS.EVENT_LIST_ATHLETE_URL.rawValue + imagePath!)
       // cell.eventsImgView?.sd_setImage(with: url)
        cell.locationLbl?.text = datasource[indexPath.row].location
        cell.startDate?.text = datasource[indexPath.row].start_date
        cell.endDate?.text = datasource[indexPath.row].end_date
        cell.distanceLbl?.text = datasource[indexPath.row].distance
       // cell.priceLbl?.text = datasource[indexPath.row].price

        
        return cell
    }
    
    
}
