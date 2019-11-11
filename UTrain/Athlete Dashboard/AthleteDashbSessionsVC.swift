//
//  AthleteDashbSessionsVC.swift
//  UTrain
//
//  Created by osx on 24/10/19.
//  Copyright © 2019 osx. All rights reserved.
//

import UIKit

class AthleteDashbSessionsVC: UIViewController {

    @IBOutlet weak var sessionTblView: UITableView?
    var datasource = [AthleteSessionListModel]()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        sessionTblView?.delegate = self
        sessionTblView?.dataSource = self
        getSessionListForAthlete()
    }
    
    class func instance()->AthleteDashbSessionsVC?{
        let storyboard = UIStoryboard(name: "AthleteDashboard", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "AthleteDashbSessionsVC") as? AthleteDashbSessionsVC
        return controller
    }
    
    func getSessionListForAthlete(){
        api.delegate = self
        var params = [String:Any]()
        params = ["search": "train",
                  "limit":  "11",
                  "order_by": "price_low"]
        
        showIndicator()
        api.getSessionsListForAthlete(url: API_ENDPOINTS.SESSIONS_LIST_ATHLETE.rawValue, params: params, viewController: self) { (model) in
            if model != nil{
                self.datasource = model
                self.sessionTblView?.reloadData()
            }
        }
    }


}
extension AthleteDashbSessionsVC: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return datasource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "sessionCell", for: indexPath) as? AthleteDashbSessionCell else{
            return UITableViewCell()
        }
        
        cell.nameLbl?.text = datasource[indexPath.row].name
        cell.addressLbl?.text = datasource[indexPath.row].location
        cell.startDate?.text = datasource[indexPath.row].date
        cell.enddate?.text = datasource[indexPath.row].end_date
        cell.timeLbl?.text = datasource[indexPath.row].start_time
        cell.distanceLbl?.text = datasource[indexPath.row].distance
        
        return cell
    }
}
