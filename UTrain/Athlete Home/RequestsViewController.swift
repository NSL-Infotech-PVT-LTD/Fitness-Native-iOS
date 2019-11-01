//
//  RequestsViewController.swift
//  UTrain
//
//  Created by osx on 27/09/19.
//  Copyright © 2019 osx. All rights reserved.
//

import UIKit

class RequestsViewController: UIViewController {

    @IBOutlet weak var roundCornerView: UIView?
    @IBOutlet weak var eventHighlightView: UIView?
    @IBOutlet weak var sessionHighlightView: UIView?
    @IBOutlet weak var placeHighlightView: UIView?
    @IBOutlet weak var serviceHighlightView: UIView?
    
    enum child : Int {
        case current    = 0
        case additional = 1
        case third      = 2
        case fourth     = 3
    }
    
    var pageController : RequestsPageVC?

    
    //MARK:- View Life-Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        roundCornerView?.rounded()
    }
    
    @IBAction func eventsActionBtn(_ sender: Any) {
        pageController?.selectTab(.current)
        
    }
    
    @IBAction func sessionsActionBtn(_ sender: Any) {
        pageController?.selectTab(.additional)
        
    }
    
    @IBAction func placesActionBtn(_ sender: Any) {
        pageController?.selectTab(.third)
    }
    
    @IBAction func servicesActionBtn(_ sender: Any) {
        pageController?.selectTab(.fourth)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        pageController = segue.destination as? RequestsPageVC
        pageController?.customDelegate = self
    }
    
    @IBAction func backActionBtn(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}

extension RequestsViewController : updateView{
    
    func updateHeader(index: Int) {
        if index == 1{
            eventHighlightView?.backgroundColor = UIColor.black
            sessionHighlightView?.backgroundColor = UIColor.clear
            placeHighlightView?.backgroundColor = UIColor.clear
            serviceHighlightView?.backgroundColor = UIColor.clear
            return
        }
        if index == 2{
            eventHighlightView?.backgroundColor = UIColor.clear
            sessionHighlightView?.backgroundColor = UIColor.black
            placeHighlightView?.backgroundColor = UIColor.clear
            serviceHighlightView?.backgroundColor = UIColor.clear
            return
        }
        if index == 3{
            eventHighlightView?.backgroundColor = UIColor.clear
            sessionHighlightView?.backgroundColor = UIColor.clear
            placeHighlightView?.backgroundColor = UIColor.black
            serviceHighlightView?.backgroundColor = UIColor.clear
            return
        }
        if index == 4{
            eventHighlightView?.backgroundColor = UIColor.clear
            sessionHighlightView?.backgroundColor = UIColor.clear
            placeHighlightView?.backgroundColor = UIColor.clear
            serviceHighlightView?.backgroundColor = UIColor.black
            return
        }
    }
}

