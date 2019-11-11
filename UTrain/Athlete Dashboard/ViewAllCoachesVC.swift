//
//  ViewAllCoachesVC.swift
//  UTrain
//
//  Created by osx on 30/10/19.
//  Copyright © 2019 osx. All rights reserved.
//

import UIKit

class ViewAllCoachesVC: UIViewController {
    
//    var imgArr = ["mask_org","mask_coach","mask_athlete"]
//    var lblArr = ["mask_org","mask_coach","mask_athlete"]
    var dataSource = [AthleteCoachListModel]()


    @IBOutlet weak var allCoachTblView: UITableView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        allCoachTblView?.delegate = self
        allCoachTblView?.dataSource = self
        getCoachList()

    }
    class func instance()->ViewAllCoachesVC?{
        let storyboard = UIStoryboard(name: "AthleteDashboard", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "ViewAllCoachesVC") as? ViewAllCoachesVC
        return controller
    }
    
    func getCoachList(){
        api.delegate = self
        var params = [String:Any]()
        params = ["search": "",
                  "limit":  20,
                  "order_by": "latest"]
        
        showIndicator()
        api.getCoachesList(url: API_ENDPOINTS.COACH_LIST.rawValue, params: params, viewController: self) { (model) in
            if model != nil {
                self.dataSource = model
                self.allCoachTblView?.reloadData()
            }
        }
        
    }

    @IBAction func backAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
}

extension ViewAllCoachesVC: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "coachCell", for: indexPath) as? ViewAllCoachCell else{
            return UITableViewCell()
        }
        let imagePath = dataSource[indexPath.row].profile_image ?? ""
        let url = URL(string: API_ENDPOINTS.COACH_IMAGE_BASE_URL.rawValue + imagePath)
        cell.imgView?.sd_setImage(with: url)
        cell.coachNameLbl?.text = dataSource[indexPath.row].name

        return cell
    }
    
    
}
