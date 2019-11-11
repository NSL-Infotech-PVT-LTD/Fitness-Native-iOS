//
//  ViewAllOrganisationVC.swift
//  UTrain
//
//  Created by osx on 05/11/19.
//  Copyright © 2019 osx. All rights reserved.
//

import UIKit

class ViewAllOrganisationVC: UIViewController {

    var dataSource = [OrganisationListModel]()
    
    @IBOutlet weak var allOrgTblView: UITableView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        allOrgTblView?.delegate = self
        allOrgTblView?.dataSource = self
        getOrgList()
        
    }
    class func instance()->ViewAllOrganisationVC?{
        let storyboard = UIStoryboard(name: "AthleteDashboard", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "ViewAllOrganisationVC") as? ViewAllOrganisationVC
        return controller
    }
    
    func getOrgList(){
        api.delegate = self
        var params = [String:Any]()
        params = ["search": "",
                  "limit":  1,
                  "order_by": "latest"]
        
        showIndicator()
        api.getOrganisationList(url: API_ENDPOINTS.ORG_LIST.rawValue, params: params, viewController: self) { (model) in
            if model != nil{
                self.dataSource = model
                self.allOrgTblView?.reloadData()
            }
        }
        
    }
    
    @IBAction func backAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
}

extension ViewAllOrganisationVC: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "orgCell", for: indexPath) as? ViewAllOrgCell else{
            return UITableViewCell()
        }
        
        let imagePath = dataSource[indexPath.row].profile_image ?? ""
        let url = URL(string: API_ENDPOINTS.ORG_IMAGE_BASE_URL.rawValue + imagePath)
        cell.img_view?.sd_setImage(with: url)
        cell.nameLbl?.text = dataSource[indexPath.row].name
        return cell
    }
    
    
}
