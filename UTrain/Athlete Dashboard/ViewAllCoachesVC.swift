//
//  ViewAllCoachesVC.swift
//  UTrain
//
//  Created by osx on 30/10/19.
//  Copyright © 2019 osx. All rights reserved.
//

import UIKit

class ViewAllCoachesVC: UIViewController {
    
    var imgArr = ["mask_org","mask_coach","mask_athlete"]
    var lblArr = ["mask_org","mask_coach","mask_athlete"]

    @IBOutlet weak var allCoachTblView: UITableView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        allCoachTblView?.delegate = self
        allCoachTblView?.dataSource = self

    }
    class func instance()->ViewAllCoachesVC?{
        let storyboard = UIStoryboard(name: "AthleteDashboard", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "ViewAllCoachesVC") as? ViewAllCoachesVC
        return controller
    }

    @IBAction func backAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
}

extension ViewAllCoachesVC: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return lblArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "coachCell", for: indexPath) as? ViewAllCoachCell else{
            return UITableViewCell()
        }
        cell.imgView?.image = UIImage(named: imgArr[indexPath.row])
        cell.coachNameLbl?.text = lblArr[indexPath.row]
        cell.contentContainerView?.rounded()
        return cell
    }
    
    
}
