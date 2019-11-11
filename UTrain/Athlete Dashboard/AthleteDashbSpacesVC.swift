//
//  AthleteDashbSpacesVC.swift
//  UTrain
//
//  Created by osx on 24/10/19.
//  Copyright © 2019 osx. All rights reserved.
//

import UIKit

class AthleteDashbSpacesVC: UIViewController {
    
    @IBOutlet weak var spacesTblView: UITableView?
    var datasource = [AthleteSpaceListModel]()

    
    //MARK:- View Life-Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        spacesTblView?.delegate = self
        spacesTblView?.dataSource = self
        getSpaceListForAthlete()

    }

    class func instance()->AthleteDashbSpacesVC?{
        let storyboard = UIStoryboard(name: "AthleteDashboard", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "AthleteDashbSpacesVC") as? AthleteDashbSpacesVC
        return controller
    }
    
    func getSpaceListForAthlete(){
        api.delegate = self
        var params = [String:Any]()
        params = ["limit":  "1",
                  "order_by": "price_low"]
        
        showIndicator()
        api.getSpaceListForAthlete(url: API_ENDPOINTS.SPACES_LIST_ATHLETE.rawValue, params: params, viewController: self) { (model) in
            if model != nil{
                self.datasource = model
                self.spacesTblView?.reloadData()
            }
        }
    }
}

extension AthleteDashbSpacesVC: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return datasource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "spacesCell", for: indexPath) as? AthleteDashbSpacesCell else {
            return UITableViewCell()
        }
        cell.nameLbl?.text = datasource[indexPath.row].name
        cell.locationLbl?.text = datasource[indexPath.row].location
        cell.distanceLbl?.text = datasource[indexPath.row].distance

        return cell
    }
    
}
