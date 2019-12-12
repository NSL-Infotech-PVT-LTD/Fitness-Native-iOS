//
//  SelectServiceVC.swift
//  Utrain
//
//  Created by NetScape Labs on 10/12/19.
//  Copyright © 2019 NetScape Labs. All rights reserved.
//

import UIKit
protocol SportsDelegate {
    func sportsData(Bool:Bool)
}

class SelectServiceVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var delegate : SportsDelegate?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        // Mark : TableView Delegate
        tableView.dataSource = self
        tableView.delegate = self
        tableView.tableFooterView = UIView()
    }
    

    @IBAction func addOnPress(_ sender: UIButton) {
        if let del = delegate{
            del.sportsData(Bool: true)
        }
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func checkOnPress(_ sender:UIButton){
        if sender.isSelected == false{
            sender.isSelected = true
        }else{
            sender.isSelected = false
        }
        
    }
    
}

extension SelectServiceVC :UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SelectSportsCell", for: indexPath)  as! SelectSportsCell
        cell.btnCheck.addTarget(self, action: #selector(checkOnPress(_:)), for: .touchUpInside)
        cell.btnCheck.tag = indexPath.row
        
        return cell
    }
    
    
}
