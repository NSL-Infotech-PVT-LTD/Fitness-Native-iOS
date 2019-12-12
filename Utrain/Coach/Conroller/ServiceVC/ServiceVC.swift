//
//  ServiceVC.swift
//  Utrain
//
//  Created by NetScape Labs on 10/12/19.
//  Copyright © 2019 NetScape Labs. All rights reserved.
//

import UIKit

class ServiceVC: UIViewController {
    
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var serviceView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Mark : TableView Delegate
        tableView.dataSource = self
        tableView.delegate = self
        tableView.tableFooterView = UIView()
        
        
        
    }
    @IBAction func addonPress(_ sender: UIButton) {
        if let vc = ViewControllerHelper.getViewController(ofType: .SelectServiceVC) as? SelectServiceVC{
            vc.delegate = self
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    @IBAction func submitOnnPress(_ sender: UIButton) {
        if let vc = ViewControllerHelper.getViewController(ofType: .DashboardVC) as? DashboardVC {
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    

}
extension ServiceVC :UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ServiceCell", for: indexPath)  as! ServiceCell
        
        
        return cell
    }
    
}

extension ServiceVC :SportsDelegate{
    func sportsData(Bool: Bool) {
        if Bool == true{
            self.serviceView.isHidden = true
        }else{
            self.serviceView.isHidden = false
        }
    }
    
    
}
