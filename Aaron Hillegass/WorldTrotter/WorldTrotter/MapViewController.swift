//
//  MapViewController.swift
//  WorldTrotter
//
//  Created by JUN LEE on 2017. 7. 2..
//  Copyright © 2017년 LEEJUN. All rights reserved.
//

import UIKit
import MapKit

@IBDesignable class MapViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {
    
    // MARK: properties
    var mapView: MKMapView!
    var locationManager: CLLocationManager!
    var latitudes: Array<Double> = []
    var longitudes: Array<Double> = []
    var currentButton = UIButton()
    
    override func loadView() {
        // 지도 뷰 생성
        mapView = MKMapView()
        
        // 지도 뷰를 이 뷰 컨트롤러의 view로 설정
        view = mapView
        
//        let segmentedControl = UISegmentedControl(items: ["Standard", "Hybrid", "satellite"])
        
        let standardString = NSLocalizedString("Standard", comment: "Standard map view")
        let satelliteString = NSLocalizedString("Satellite", comment: "Satellite map view")
        let hybridString = NSLocalizedString("Hybrid", comment: "Hybrid map view")
        let segmentedControl = UISegmentedControl(items: [standardString, satelliteString, hybridString])
        
        segmentedControl.backgroundColor = UIColor.white.withAlphaComponent(0.5)
        segmentedControl.selectedSegmentIndex = 0
        
        segmentedControl.addTarget(self, action: #selector(MapViewController.mapTypeChanged(_:)), for: .valueChanged)
        
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(segmentedControl)
        
        let topConstraint = segmentedControl.topAnchor.constraint(equalTo: topLayoutGuide.bottomAnchor, constant: 8)
        let margins = view.layoutMarginsGuide
        let leadingConstraint = segmentedControl.leadingAnchor.constraint(equalTo: margins.leadingAnchor)
        let trailingConstraint = segmentedControl.trailingAnchor.constraint(equalTo: margins.trailingAnchor)
        
        topConstraint.isActive = true
        leadingConstraint.isActive = true
        trailingConstraint.isActive = true
    }
    
    func mapTypeChanged(_ segControl: UISegmentedControl) {
        switch segControl.selectedSegmentIndex {
        case 0:
            mapView.mapType = .standard
        case 1:
            mapView.mapType = .hybrid
        case 2:
            mapView.mapType = .satellite
        default:
            break
        }
    }

    override func viewDidLoad() {
        // super의 viewDidLoad 구현을 항상 호출한다
        super.viewDidLoad()
        
        print("MapViewController loaded its view.")
        
        setUpCurrentButton()
    }
    
    // MARK: Button Functions
    
    private func setUpCurrentButton() {
        currentButton.setTitle("Current Location", for: .normal)
        currentButton.setTitleColor(.blue, for: .normal)
        currentButton.backgroundColor = UIColor.white.withAlphaComponent(0.5)
        currentButton.translatesAutoresizingMaskIntoConstraints = false
        currentButton.addTarget(self, action: #selector(currentLocation(sender:)), for: .touchUpInside)
        view.addSubview(currentButton)
        
        let bottomConstraintBtn = currentButton.bottomAnchor.constraint(equalTo: bottomLayoutGuide.topAnchor, constant: -8)
        let marginsBtn = view.layoutMarginsGuide
        let leadingConstraintBtn = currentButton.leadingAnchor.constraint(equalTo: marginsBtn.leadingAnchor)
        let trailingConstraintBtn = currentButton.trailingAnchor.constraint(equalTo: marginsBtn.trailingAnchor)
        
        bottomConstraintBtn.isActive = true
        leadingConstraintBtn.isActive = true
        trailingConstraintBtn.isActive = true
    }
    
    func currentLocation(sender: AnyObject) {
        mapView.delegate = self
        mapView.showsUserLocation = true
        
//        mapView.setUserTrackingMode(.follow, animated: true)

        locationManager = CLLocationManager()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.delegate = self
        let currentLatitude = locationManager.location?.coordinate.latitude ?? 0.0
        let currentLongitude = locationManager.location?.coordinate.longitude ?? 0.0
        
        latitudes.append(currentLatitude)
        longitudes.append(currentLongitude)
        
        let noLocation = CLLocationCoordinate2DMake(currentLatitude, currentLongitude)
        let region = MKCoordinateRegionMakeWithDistance(noLocation, 200, 200)
        mapView.setRegion(region, animated: true)
        
        locationManager.startUpdatingLocation()
    }
    
}
