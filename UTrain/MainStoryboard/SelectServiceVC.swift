//
//  SelectServiceVC.swift
//  UTrain
//
//  Created by osx on 15/10/19.
//  Copyright © 2019 osx. All rights reserved.
//

import UIKit

class SelectServiceVC: UIViewController {
    
    var dataSource = [ServicesModel]()
    
    @IBOutlet weak var serviceName1Lbl: UILabel!
    @IBOutlet weak var serviceName2Lb: UILabel!
    @IBOutlet weak var serviceName3Lbl: UILabel!

    @IBOutlet weak var tbl_view: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getService()
        tbl_view.delegate = self
        tbl_view.dataSource = self

    }
    

    class func instance()-> SelectServiceVC?{
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "SelectServiceVC") as? SelectServiceVC
        return controller
    }

    @IBAction func backAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }

    func getService(){
        api.delegate = self
        let params = [String:Any]()
        showIndicator()
        api.getServices(url: API_ENDPOINTS.GET_SERVICE.rawValue, params: params, viewController: self) { (model) in
            print("the modelllll\(model)")
                self.dataSource = model
                self.tbl_view?.reloadData()
            }
    }
    
}


extension SelectServiceVC: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
       
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "SelectServiceTableCell", for: indexPath) as? SelectServiceTableCell else{
            return UITableViewCell()
        }
        
        cell.serviceNameLbl?.text = dataSource[indexPath.row].name
        
        return cell
    }
    
    
}
