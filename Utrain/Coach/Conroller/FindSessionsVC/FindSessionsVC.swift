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
import SearchTextField


struct State {
    let name: String
    let long: CLLocationDegrees
    let lat: CLLocationDegrees
}
class FindSessionsVC: UIViewController,GMSMapViewDelegate {
    
    @IBOutlet weak var txtSearch: SearchTextField!
    @IBOutlet weak var mapView: GMSMapView!
    var markerDict: [String: GMSMarker] = [:]
    let states = [
        State(name: "Alaska", long: -152.404419, lat: 61.370716),
        State(name: "Alabama", long: -86.791130, lat: 32.806671),
        // the other 51 states here...
    ]
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Mark : SearchTextFeild Attrubute's
        self.txtSearch.filterStrings(["Red","Ress","Rasjdja", "Blue", "Yellow"])
        self.setSearchTextFeild()
        
        // Mark Add marker On Map View
        self.loadMapView()
        
        
    }
    @IBAction func currentLocationOnPress(_ sender: UIButton) {
        
    }
    
    func mapView(_ mapView: GMSMapView, didTapInfoWindowOf marker: GMSMarker) {
        print("Done")
    }
    
    func setSearchTextFeild(){
        txtSearch.theme = SearchTextFieldTheme.lightTheme()
        // Modify current theme properties
        txtSearch.theme.font = UIFont.systemFont(ofSize: 12)
        txtSearch.theme.bgColor = .white
        txtSearch.theme.subtitleFontColor = .black
        txtSearch.theme.borderColor = UIColor (red: 0.9, green: 0.9, blue: 0.9, alpha: 1)
        txtSearch.theme.separatorColor = UIColor (red: 0.9, green: 0.9, blue: 0.9, alpha: 0.5)
        txtSearch.theme.cellHeight = 50
        // Set the max number of results. By default it's not limited
        txtSearch.maxNumberOfResults = 5
        // Then set the inline mode in true
        //        txtSearch.inlineMode = true
        txtSearch.itemSelectionHandler = {filteredResults, itemPosition in
            print("CheckDone")
            // Just in case you need the item position
            let item = filteredResults[itemPosition]
            print("Item at position \(itemPosition): \(item.title)")
            if let vc = ViewControllerHelper.getViewController(ofType: .SpacesVC) as? SpacesVC {
                self.navigationController?.pushViewController(vc, animated: true)
            }
            
            // Do whatever you want with the picked item
            self.txtSearch.text = item.title
        }
    }
    
    @IBAction func backOnPress(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    func loadMapView(){
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
            state_marker.icon = #imageLiteral(resourceName: "Marker")
            state_marker.setIconSize(scaledToSize: .init(width: 15, height: 20))
            markerDict[state.name] = state_marker
            
        }
    }
}

