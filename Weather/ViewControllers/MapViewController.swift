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
    
    let segueIdShowList: String = "ShowListSegue"

    @IBOutlet weak var mvWeather: MKMapView!
    
    private let locationManager = CLLocationManager()
    
    private var currentPin: MKPointAnnotation?
    
    // MARK: - ViewController lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initialSetup();
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: - Setup
    func initialSetup() {
        
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapMapView(_:)))
        mvWeather.addGestureRecognizer(tapGesture);
        
    }
    
    // MARK: - Handle screen events
    func didTapMapView(sender: UITapGestureRecognizer) {
        
        if sender.state == .Ended {
            
            let locationTapped = sender.locationInView(mvWeather)
            let coordinate = mvWeather.convertPoint(locationTapped, toCoordinateFromView: mvWeather)
            
            if currentPin == nil {
                currentPin = MKPointAnnotation()
            }
            
            mvWeather.removeAnnotation(currentPin!)
            
            currentPin!.coordinate = coordinate
            mvWeather.addAnnotation(currentPin!)
            
        }
        
    }
    
    @IBAction func didTapSearchButton(sender: AnyObject) {
        
        if currentPin != nil {
            performSegueWithIdentifier(segueIdShowList, sender: self)
        } else {
            showMessageAlert("Erro", message: "Por favor, escolha um local no mapa", cancelButton: "OK")
        }
        
    }
    
    // MARK: - Navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if let nextVC = segue.destinationViewController as? ListCitiesWeatherViewController {
            
            nextVC.selectedCoordinate = currentPin!.coordinate
            
        }
        
    }
    
}

