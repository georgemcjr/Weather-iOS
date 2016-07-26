//
//  MapViewController.swift
//  Weather
//
//  Created by George Cavalcanti on 7/26/16.
//  Copyright © 2016 George Cavalcanti. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController {

    @IBOutlet weak var mapView: MKMapView!
    
    // MARK: - ViewController lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initialSetup();
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Setup
    func initialSetup() {
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapMapView(_:)))
        mapView.addGestureRecognizer(tapGesture);
        
    }
    
    // MARK: - Handle gestures
    func didTapMapView(sender: UITapGestureRecognizer) {
        
        if sender.state == .Ended {
            
            let locationTapped = sender.locationInView(mapView)
            print("Tapped location: \(locationTapped)")
            
            let coordinates = mapView.convertPoint(locationTapped, toCoordinateFromView: mapView)
            print("Coordinates: \(coordinates)")
            
        }
        
    }
    
    
    
    
    


}

