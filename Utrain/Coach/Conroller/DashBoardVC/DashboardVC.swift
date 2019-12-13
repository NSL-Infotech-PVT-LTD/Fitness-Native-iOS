//
//  DashboardVC.swift
//  Utrain
//
//  Created by NetScape Labs on 10/12/19.
//  Copyright © 2019 NetScape Labs. All rights reserved.
//

import UIKit
import  Pulley

class DashboardVC: UIViewController {

    @IBOutlet weak var myCollectionViewHeight: NSLayoutConstraint!
    @IBOutlet weak var tableViewHeight: NSLayoutConstraint!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var lblBio: UILabel!
    @IBOutlet weak var lblAchivement: UILabel!
    @IBOutlet weak var lblExperience: UILabel!
    @IBOutlet weak var lblSports: UILabel!
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var lblWelcomeName: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.lblWelcomeName.text = "Welcome Pankaj"
        //Mark: CollectionView Delegate
        collectionView.delegate = self
        collectionView.dataSource = self
        
        //Mark: Tableview Delegate
        tableView.delegate = self
        tableView.dataSource = self
        self.tableView.addObserver(self, forKeyPath: "contentSize", options: NSKeyValueObservingOptions.new, context: nil)
        
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        let height = collectionView.collectionViewLayout.collectionViewContentSize.height
        myCollectionViewHeight.constant = height
        self.view.layoutIfNeeded()
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        tableView.layer.removeAllAnimations()
        tableViewHeight.constant = tableView.contentSize.height + 50
        UIView.animate(withDuration: 0.5) {
            self.updateViewConstraints()
            self.loadViewIfNeeded()
        }
        
    }
    override func viewWillAppear(_ animated: Bool) {
        self.collectionView.reloadData()
    }

    @IBAction func viewAllOnPress(_ sender: UIButton) {
        let mainContentVC = UIStoryboard(name: "Coach", bundle: nil).instantiateViewController(withIdentifier: "FindSessionsVC")
        
        let drawerContentVC = UIStoryboard(name: "Coach", bundle: nil).instantiateViewController(withIdentifier: "DrawerContentVC")
        
        let pulleyController = PulleyViewController(contentViewController: mainContentVC, drawerViewController: drawerContentVC)
        self.navigationController?.pushViewController(pulleyController,animated: true)
        
    }
    
    
    @IBAction func createEvenOnPress(_ sender: UITapGestureRecognizer) {
        if let vc = ViewControllerHelper.getViewController(ofType: .CreateEventVC) as? CreateEventVC {
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    @IBAction func createSessionOnPress(_ sender: UITapGestureRecognizer) {
        if let vc = ViewControllerHelper.getViewController(ofType: .CreateTrainingVC) as? CreateTrainingVC {
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    @IBAction func findSpaceOnPress(_ sender: UITapGestureRecognizer) {
        let mainContentVC = UIStoryboard(name: "Coach", bundle: nil).instantiateViewController(withIdentifier: "FindSessionsVC")
        
        let drawerContentVC = UIStoryboard(name: "Coach", bundle: nil).instantiateViewController(withIdentifier: "DrawerContentVC")
        
        let pulleyController = PulleyViewController(contentViewController: mainContentVC, drawerViewController: drawerContentVC)
        self.navigationController?.pushViewController(pulleyController,animated: true)
    }
}


extension DashboardVC: UICollectionViewDelegate,UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DashboardServicesCell", for: indexPath) as! DashboardServicesCell
        let str = "abcdfghigklmojasdgk"
        cell.lblService.text = str
        cell.lblWidth.constant = str.widthOfString(usingFont: UIFont.systemFont(ofSize: 14.0))
        cell.layoutIfNeeded()
        
        return cell
    }
    
  
}

extension DashboardVC : UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 7
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "spacesCell", for: indexPath) as! spacesCell
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = ViewControllerHelper.getViewController(ofType: .SpacesVC) as? SpacesVC{
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}

extension String {
    
    func widthOfString(usingFont font: UIFont) -> CGFloat {
        let fontAttributes = [NSAttributedString.Key.font: font]
        let size = self.size(withAttributes: fontAttributes)
        return size.width
}
}
