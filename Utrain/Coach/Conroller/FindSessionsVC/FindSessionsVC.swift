//
//  FindSessionsVC.swift
//  Utrain
//
//  Created by NetScape Labs on 11/12/19.
//  Copyright © 2019 NetScape Labs. All rights reserved.
//

import UIKit
import GoogleMaps
import GooglePlacePicker

struct State {
    let name: String
    let long: CLLocationDegrees
    let lat: CLLocationDegrees
}
class FindSessionsVC: UIViewController,GMSMapViewDelegate {

    @IBOutlet weak var mapView: GMSMapView!
    var markerDict: [String: GMSMarker] = [:]
    let states = [
        State(name: "Alaska", long: -152.404419, lat: 61.370716),
        State(name: "Alabama", long: -86.791130, lat: 32.806671),
        // the other 51 states here...
    ]
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.mapView.delegate = self
        self.mapView.settings.myLocationButton = true
        // Create a GMSCameraPosition that tells the map to display the
        // coordinate -33.86,151.20 at zoom level 6.
//        let camera = GMSCameraPosition.camera(withLatitude: -86.791130, longitude: 32.806671, zoom: 9.0)
//        let mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
//        view = mapView
        // Creates a marker in the center of the map.
        for state in states {
            let state_marker = GMSMarker()
            state_marker.position = CLLocationCoordinate2D(latitude: state.lat, longitude: state.long)
            state_marker.title = state.name
            state_marker.snippet = "Hey, this is asdavgvsd\nghasdfhsga\nsfdhgasfdhgasasd\(state.name)"
            state_marker.map = mapView
            state_marker.icon = #imageLiteral(resourceName: "Mask Group 13")
            markerDict[state.name] = state_marker
   
        }
//        self.mapView?.delegate = self
        
    }
 
    func mapView(_ mapView: GMSMapView, didTapInfoWindowOf marker: GMSMarker) {
        print("Done")
    }
}
