//
//  HomeViewModel.swift
//  Food App
//
//  Created by Mohsen Abdollahi on 11/14/20.
//

import SwiftUI
import CoreLocation

//MARK:- Fetching User Location...
class HomeViewModel : NSObject, ObservableObject, CLLocationManagerDelegate {
    
    @Published var locationManager = CLLocationManager()
    @Published var search: String  = ""
    
    //Location Detailes...
    @Published var userLocation: CLLocation!
    @Published var userAddress: String = ""
    @Published var noLocation = false
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        // Checking Location Access...
        switch manager.authorizationStatus {
        case .authorizedWhenInUse:
            print("authorized")
            self.noLocation = false
            manager.requestLocation()
        case .denied:
            print("denied")
            self.noLocation = true
        default:
            print("unknown")
            self.noLocation = false
            
            // Direct Call...
            locationManager.requestWhenInUseAuthorization()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error.localizedDescription)
    }
   
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        // Read user location and Extraction Detailes...
        
        self.userLocation = locations.last
        self.extracLocation()
    }
    
    func extracLocation() {
        CLGeocoder().reverseGeocodeLocation(self.userLocation) { (res, err) in
            
            guard let safeData = res  else { return }
            var address = ""
            
            //getting area and location name
            address += safeData.first?.name ?? ""
            address += " , "
            address += safeData.first?.locality ?? ""
            
            self.userAddress = address
        }
    }
}
