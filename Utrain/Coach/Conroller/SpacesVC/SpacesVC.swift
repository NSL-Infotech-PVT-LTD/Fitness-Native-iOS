//
//  SpacesVC.swift
//  Utrain
//
//  Created by NetScape Labs on 10/12/19.
//  Copyright © 2019 NetScape Labs. All rights reserved.
//

import UIKit

class SpacesVC: UIViewController {

    @IBOutlet weak var collecetionView: UICollectionView!
    @IBOutlet weak var imgNav: UIImageView!
    @IBOutlet weak var pageControl: UIPageControl!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Mark Set Corner radius
      imgNav.roundCorners([.bottomLeft,.bottomRight], radius: 20.0)
        
        // Mark Collection View Delegate
        collecetionView.delegate = self
        collecetionView.dataSource = self
        
    }
    
    @IBAction func backOnPress(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func joinNowOnPress(_ sender: UIButton) {
        if let vc = ViewControllerHelper.getViewController(ofType: .BookingVC) as? BookingVC {
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    @IBAction func directionPress(_ sender: UIButton) {
        openTrackerInBrowser(lat: "", long: "", dlat: "", dlong: "")
    }
   
    
}



extension SpacesVC :UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        self.pageControl.numberOfPages = 3
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SpacesImageCell", for: indexPath) as! SpacesImageCell
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height = collectionView.frame.height
        let width = collectionView.frame.width
        return CGSize(width: width, height: height)
    }

    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        pageControl.currentPage = indexPath.row
    }
    func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if pageControl.currentPage == indexPath.row {
            pageControl.currentPage = collectionView.indexPath(for: collectionView.visibleCells.first!)!.row
        }
    }
    
}
