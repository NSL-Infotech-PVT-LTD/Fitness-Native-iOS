//
//  LocationOnMapVC.swift
//  Utrain
//
//  Created by NetScape Labs on 13/12/19.
//  Copyright © 2019 NetScape Labs. All rights reserved.
//

import UIKit
import GoogleMaps
import GooglePlaces
import SearchTextField

class LocationOnMapVC: UIViewController {
    
    @IBOutlet weak var txtSearch: UITextField!
    
    @IBOutlet weak var mapView: GMSMapView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Mark : MapView Delegate
        self.mapView.delegate = self
    
    }
    
    @IBAction func backOnPress(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func locationBtnOnPress(_ sender: UIButton) {
    }
    
    
    func getAddressFromLatLon(pdblLatitude: String, withLongitude pdblLongitude: String) {
        var center : CLLocationCoordinate2D = CLLocationCoordinate2D()
        let lat: Double = Double("\(pdblLatitude)")!
        //21.228124
        let lon: Double = Double("\(pdblLongitude)")!
        //72.833770
        let ceo: CLGeocoder = CLGeocoder()
        center.latitude = lat
        center.longitude = lon
        
        let loc: CLLocation = CLLocation(latitude:center.latitude, longitude: center.longitude)
        
        
        ceo.reverseGeocodeLocation(loc, completionHandler:
            {(placemarks, error) in
                if (error != nil)
                {
                    print("reverse geodcode fail: \(error!.localizedDescription)")
                }
                let pm = placemarks! as [CLPlacemark]
                
                if pm.count > 0 {
                    let pm = placemarks![0]
                    print(pm.country)
                    print(pm.locality)
                    print(pm.subLocality)
                    print(pm.thoroughfare)
                    print(pm.postalCode)
                    print(pm.subThoroughfare)
                    var addressString : String = ""
                    if pm.subLocality != nil {
                        addressString = addressString + pm.subLocality! + ", "
                    }
                    if pm.thoroughfare != nil {
                        addressString = addressString + pm.thoroughfare! + ", "
                    }
                    if pm.locality != nil {
                        addressString = addressString + pm.locality! + ", "
                    }
                    if pm.country != nil {
                        addressString = addressString + pm.country! + ", "
                    }
                    if pm.postalCode != nil {
                        addressString = addressString + pm.postalCode! + " "
                    }
                    
                    print(addressString)
                    self.txtSearch.text = addressString
                }
        })
        
    }
    func addMakerOntap(withLatitude:CLLocationDegrees,longitude:CLLocationDegrees){
        // Create a GMSCameraPosition that tells the map to display the
        // coordinate -33.86,151.20 at zoom level 6.
        let camera = GMSCameraPosition.camera(withLatitude: withLatitude, longitude: longitude, zoom: 6.0)
         mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        view = mapView
        // Creates a marker in the center of the map.
        let marker = GMSMarker()
        marker.icon = #imageLiteral(resourceName: "Marker")
        marker.setIconSize(scaledToSize: .init(width: 15, height: 20))
        marker.position = CLLocationCoordinate2D(latitude: withLatitude, longitude:longitude)

        marker.map = mapView
    }
}

extension LocationOnMapVC : GMSMapViewDelegate {
    func mapView(_ mapView: GMSMapView, didTapAt coordinate: CLLocationCoordinate2D) {
        print(coordinate.latitude)
        addMakerOntap(withLatitude: coordinate.latitude, longitude: coordinate.longitude)
//        self.getAddressFromLatLon(pdblLatitude: "\(coordinate.latitude)", withLongitude: "\(coordinate.longitude)")
    }
}
