//
//  AthleteDashboardVC.swift
//  UTrain
//
//  Created by osx on 14/10/19.
//  Copyright © 2019 osx. All rights reserved.
//

import UIKit
import Pulley
import SDWebImage

class AthleteDashboardVC: UIViewController {
    
    //MARK:- Outlets and Variables
    @IBOutlet weak var eventHeaderView: UIView?
    @IBOutlet weak var sessionHeaderView: UIView?
    @IBOutlet weak var spacesHeaderView: UIView?
    @IBOutlet weak var containerView: UIView?
    
    @IBOutlet weak var findServiceHeaderView: UIView?
    
    enum child : Int {
        case first  = 0
        case second = 1
        case third  = 2
    }
    @IBOutlet weak var coachCollectView: UICollectionView?
    @IBOutlet weak var orgCollectView: UICollectionView?
    
    @IBOutlet weak var nearbyViewAllView: UIView?
    var pageController : AthleteDashboardPageVC?
    var coachArr = ["coach1","coach2","coach3"]
    var orgArr   = ["org1","org2","org3"]
    var imgArr   = ["mask_athlete","mask_coach","mask_org"]
    var dataSource = [AthleteCoachListModel]()
    var orgDatasource = [OrganisationListModel]()


    //MARK:- View Life-Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        coachCollectView?.delegate = self
        coachCollectView?.dataSource = self
        orgCollectView?.delegate = self
        orgCollectView?.dataSource = self
        navigationController?.navigationBar.isHidden = true
        findServiceHeaderView?.rounded()
        
        eventHeaderView?.rounded()
        sessionHeaderView?.rounded()
        spacesHeaderView?.rounded()
        nearbyViewAllView?.rounded()

        
        containerView?.clipsToBounds = true
        containerView?.layer.cornerRadius = 25
        containerView?.layer.maskedCorners = [.layerMinXMinYCorner,.layerMaxXMinYCorner]
        containerView?.layer.shadowColor = UIColor.gray.cgColor
//        containerView?.layer.borderColor = UIColor.gray.cgColor
        containerView?.layer.borderWidth = 1
        getCoachList()
        getOrgList()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
//        if segue.identifier == "pageView"{
//            pageController = segue.destination as? AthleteDashboardPageVC
//
//        }
        pageController = segue.destination as? AthleteDashboardPageVC
        pageController?.customDeleg = self
    }

    class func instance()->AthleteDashboardVC?{
        let storyboard = UIStoryboard(name: "AthleteDashboard", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "AthleteDashboardVC") as? AthleteDashboardVC
        return controller
    }
    
    func getCoachList(){
        api.delegate = self
        var params = [String:Any]()
        params = ["search": "",
                  "limit":  1,
                  "order_by": "latest"]
        
        showIndicator()
        api.getCoachesList(url: API_ENDPOINTS.COACH_LIST.rawValue, params: params, viewController: self) { (model) in
            if model != nil {
                self.dataSource = model
                self.coachCollectView?.reloadData()
            }
        }
        
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
                self.orgDatasource = model
                self.orgCollectView?.reloadData()
            }
        }
        
    }
    
    //MARK:- Action Buttons
    @IBAction func eventsActionBtn(_ sender: Any) {
        
        print("fhfjhvjhvjhvjhghjgjhgjkhg\(pageController)")
        pageController?.selectTab(.first)
    }
    
    @IBAction func sessionsActionBtn(_ sender: Any) {
        pageController?.selectTab(.second)
    }
    
    @IBAction func spacesActionbtn(_ sender: Any) {
        pageController?.selectTab(.third)
    }
    
    
    @IBAction func findSessionActionBtn(_ sender: Any) {
        let mainContentVC = UIStoryboard(name: "AthleteDashboard", bundle: nil).instantiateViewController(withIdentifier: "FindSessionsVC")
        
        let drawerContentVC = UIStoryboard(name: "AthleteDashboard", bundle: nil).instantiateViewController(withIdentifier: "DrawerContentViewController")
        
        let pulleyController = PulleyViewController(contentViewController: mainContentVC, drawerViewController: drawerContentVC)
        
        self.present(pulleyController, animated: true, completion: nil)
    }
    
    @IBAction func findEventActionBtn(_ sender: Any) {
        let mainContentVC = UIStoryboard(name: "AthleteDashboard", bundle: nil).instantiateViewController(withIdentifier: "FindSessionsVC")
        
        let drawerContentVC = UIStoryboard(name: "AthleteDashboard", bundle: nil).instantiateViewController(withIdentifier: "DrawerContentViewController")
        
        let pulleyController = PulleyViewController(contentViewController: mainContentVC, drawerViewController: drawerContentVC)
        
        self.present(pulleyController, animated: true, completion: nil)
        
    }
    
    @IBAction func findSpaceActionBtn(_ sender: Any) {
        let mainContentVC = UIStoryboard(name: "AthleteDashboard", bundle: nil).instantiateViewController(withIdentifier: "FindSessionsVC")
        
        let drawerContentVC = UIStoryboard(name: "AthleteDashboard", bundle: nil).instantiateViewController(withIdentifier: "DrawerContentViewController")
        
        let pulleyController = PulleyViewController(contentViewController: mainContentVC, drawerViewController: drawerContentVC)
        
        self.present(pulleyController, animated: true, completion: nil)
    }
    
    @IBAction func viewAllCoachesAction(_ sender: Any) {
      
       guard let controller = ViewAllCoachesVC.instance() else{
            return
        }
       self.present(controller, animated: true)

   }
    
    
    @IBAction func viewAllOrgAction(_ sender: Any) {
        guard let controller = ViewAllOrganisationVC.instance() else{
            return
        }
        self.present(controller, animated: true)
        
    }
    
}

extension AthleteDashboardVC: UICollectionViewDelegate, UICollectionViewDataSource{
   
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == coachCollectView{
            return dataSource.count
        }
        if collectionView == orgCollectView{
            return orgDatasource.count
        }
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == coachCollectView{
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CoachCell", for: indexPath) as? CoachCollectVCell  else{
            return UICollectionViewCell()
        }
            let imagePath = dataSource[indexPath.row].profile_image ?? ""
            let url = URL(string: API_ENDPOINTS.COACH_IMAGE_BASE_URL.rawValue + imagePath)
            cell.coachImgView?.sd_setImage(with: url)
            cell.coachLbl?.text = dataSource[indexPath.row].name

            return cell
            
    }
        if collectionView == orgCollectView{
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "OrgCell", for: indexPath) as? OrgCollectionVCell else{
                return UICollectionViewCell()
            }
            let imagePath = orgDatasource[indexPath.row].profile_image ?? ""
            let url = URL(string: API_ENDPOINTS.ORG_IMAGE_BASE_URL.rawValue + imagePath)
            cell.orgImgView?.sd_setImage(with: url)
            cell.orgLabel?.text = orgDatasource[indexPath.row].name
            
            return cell
        }
        return UICollectionViewCell()
    
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
}

extension AthleteDashboardVC: updation{
    func updateHeader(index: Int) {
        if index == 1{
            eventHeaderView?.backgroundColor = UIColor.green
            sessionHeaderView?.backgroundColor = UIColor.clear
            spacesHeaderView?.backgroundColor = UIColor.clear
            return
        }
        if index == 2{
            eventHeaderView?.backgroundColor = UIColor.clear
            sessionHeaderView?.backgroundColor = UIColor.green
            spacesHeaderView?.backgroundColor = UIColor.clear
            return
        }
        if index == 3{
            eventHeaderView?.backgroundColor = UIColor.clear
            sessionHeaderView?.backgroundColor = UIColor.clear
            spacesHeaderView?.backgroundColor = UIColor.green
            return
        }
        
    }
    
    
}
