//
//  MapViewController.swift
//  MoovupTest
//
//  Created by Yansong Wang on 2022/3/1.
//

import UIKit
import MapKit

class MapViewController: UIViewController {

    var persons: [Person] = []
    let mapView = MKMapView()
    var safeArea: UILayoutGuide!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.white
        self.safeArea = self.view.layoutMarginsGuide
        
        self.view.addSubview(self.mapView)
    }
    
    override func viewWillLayoutSubviews() {
        self.mapView.frame = CGRect(x: 0, y: self.safeArea.layoutFrame.origin.y, width: self.view.frame.width, height: self.safeArea.layoutFrame.size.height)
    }

    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = false
        
        Person.getAllPersons(url: "https://api.json-generator.com/templates/-xdNcNKYtTFG/data") { results in
            self.persons = results
            self.addAnnotions()
        } _: { _ in
            self.persons = PersonData.get()
            self.addAnnotions()
        }
    }
    
    func setMapView() {
        self.mapView.mapType = .standard
        self.mapView.isZoomEnabled = true
        self.mapView.isScrollEnabled = true
    }
    
    func addAnnotions() {
        var latSum: Double = 0
        var lngSum: Double = 0
        for person in self.persons {
            latSum += person.location.lat
            lngSum += person.location.lng
            self.addAnnotion(person: person)
        }
        
        self.setRegion(lat: latSum / Double(self.persons.count), lng: lngSum / Double(self.persons.count))
    }
    
    func setRegion(lat: Double, lng: Double) {
        var region = MKCoordinateRegion()
        
        region.center = CLLocationCoordinate2D(latitude: lat, longitude: lng)
        
        region.span.latitudeDelta = 0.2
        region.span.longitudeDelta = 0.2
        
        self.mapView.setRegion(region, animated: true)
    }
    
    func addAnnotion(person: Person) {
        let annotion = MKPointAnnotation()
        annotion.coordinate = CLLocationCoordinate2D(latitude: person.location.lat, longitude: person.location.lng)
        annotion.subtitle = person.first_name + " " + person.last_name
        self.mapView.addAnnotation(annotion)
    }
}
