//
//  DrawerContentVC.swift
//  Utrain
//
//  Created by NetScape Labs on 11/12/19.
//  Copyright © 2019 NetScape Labs. All rights reserved.
//

import UIKit

class DrawerContentVC: UIViewController {

    @IBOutlet weak var lblDisc: UILabel!
    @IBOutlet weak var lblSessionName: UILabel!
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Mark : TableView Delegate
        tableView.delegate = self
        tableView.dataSource = self
    }
    

    @IBAction func backOnPress(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
        self.dismiss(animated: true, completion: nil)
    }
    
}


extension DrawerContentVC : UITableViewDataSource,UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SessionCell", for: indexPath) as! SessionCell
        return cell
    }
    
    
}
