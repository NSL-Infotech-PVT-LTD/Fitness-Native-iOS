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
    
    //MARK:- View Life-Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        spacesTblView?.delegate = self
        spacesTblView?.dataSource = self

    }

    class func instance()->AthleteDashbSpacesVC?{
        let storyboard = UIStoryboard(name: "AthleteDashboard", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "AthleteDashbSpacesVC") as? AthleteDashbSpacesVC
        return controller
    }
}

extension AthleteDashbSpacesVC: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "spacesCell", for: indexPath) as? AthleteDashbSpacesCell else {
            return UITableViewCell()
        }
        cell.spacesImgView?.image = UIImage(named: "gps")
        cell.spacesImgContainer?.rounded()
        return cell
    }
    
}
