//
//  ChooseSportsVC.swift
//  Utrain
//
//  Created by NetScape Labs on 10/12/19.
//  Copyright © 2019 NetScape Labs. All rights reserved.
//

import UIKit

class ChooseSportsVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Mark : TableView Delegate
        tableView.dataSource = self
        tableView.delegate = self
        tableView.tableFooterView = UIView()
    }
    
    // Mark : BtnCheck Action
    
    @objc func checkOnPress(_ sender:UIButton){
        if sender.isSelected == false{
            sender.isSelected = true
        }else{
            sender.isSelected = false
        }
        
    }
 
    @IBAction func moreStepOnPress(_ sender: UIButton) {
        if let vc = ViewControllerHelper.getViewController(ofType: .ServiceVC) as? ServiceVC {
            
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    @IBAction func backOnPress(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
}


extension ChooseSportsVC :UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SportsCell", for: indexPath)  as! SportsCell
        cell.btnCheck.addTarget(self, action: #selector(checkOnPress(_:)), for: .touchUpInside)
        cell.btnCheck.tag = indexPath.row
        
        return cell
    }
    
    
}
