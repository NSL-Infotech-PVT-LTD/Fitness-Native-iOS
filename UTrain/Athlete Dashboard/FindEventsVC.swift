//
//  FindEventsVC.swift
//  UTrain
//
//  Created by osx on 01/11/19.
//  Copyright © 2019 osx. All rights reserved.
//

import UIKit
import GoogleMaps

class FindEventsVC: UIViewController {

    //MARK:- Outlets and Variables
    @IBOutlet weak var mapView: GMSMapView!
    var location = CLLocationCoordinate2D()
    
    //MARK:- View Life-cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        camera()
    }
    
    class func instance()-> FindEventsVC?{
        let storyboard = UIStoryboard(name: "AthleteDashboard", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "FindEventsVC") as? FindEventsVC
        return controller
    }
    
    func camera(){
        let camera = GMSCameraPosition.camera(withLatitude: location.latitude, longitude: location.longitude, zoom: 6.0)
        mapView.camera = camera
        self.showMarker(position: mapView.camera.target)
    }
    
    func showMarker(position: CLLocationCoordinate2D){
        let marker = GMSMarker()
        marker.position = position
        marker.title = ""
        marker.map = mapView
        
    }

    @IBAction func backActionBtn(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    


}
