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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sessionTblView?.delegate = self
        sessionTblView?.dataSource = self
    }
    
    class func instance()->AthleteDashbSessionsVC?{
        let storyboard = UIStoryboard(name: "AthleteDashboard", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "AthleteDashbSessionsVC") as? AthleteDashbSessionsVC
        return controller
    }


}
extension AthleteDashbSessionsVC: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "sessionCell", for: indexPath) as? AthleteDashbSessionCell else{
            return UITableViewCell()
        }
        cell.sessionImgView?.image = UIImage(named: "greenShadow")
        cell.sessionImgContainer?.rounded()
        
        return cell
    }
}
