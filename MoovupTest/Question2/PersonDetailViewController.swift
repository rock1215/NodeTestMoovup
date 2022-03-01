//
//  PersonDetailViewController.swift
//  MoovupTest
//
//  Created by Yansong Wang on 2022/3/1.
//

import UIKit
import MapKit

class PersonDetailViewController: UIViewController {

    var person: Person?
    let mapView = MKMapView()
    var safeArea: UILayoutGuide!
    
    var footer = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = self.person!.first_name + " " + self.person!.last_name
        
        self.view.backgroundColor = UIColor.white
        self.safeArea = self.view.layoutMarginsGuide
        
        self.view.addSubview(self.mapView)
        self.setMapView()
        
        self.footer.backgroundColor = UIColor.white
        self.view.addSubview(self.footer)
        
        self.setFooter()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = true
    }
    
    override func viewWillLayoutSubviews() {
        let height = self.safeArea.layoutFrame.size.height
        
        self.mapView.frame = CGRect(x: 0, y: self.safeArea.layoutFrame.origin.y, width: self.view.frame.width, height: height - 56)
        
        self.footer.frame = CGRect(x: 0, y: self.safeArea.layoutFrame.origin.y + height - 56, width: self.view.frame.width, height: 56)
    }
    
    func setMapView() {
        self.mapView.mapType = .standard
        self.mapView.isZoomEnabled = true
        self.mapView.isScrollEnabled = true
        self.mapView.register(MKMarkerAnnotationView.self, forAnnotationViewWithReuseIdentifier: "annotion")
        self.mapView.delegate = self
        
        let location = CLLocationCoordinate2D(latitude: self.person!.location.lat, longitude: self.person!.location.lng)
        
        self.setRegion(location: location)
        self.addPin(location: location)
    }

    func setFooter() {
        let imageView = UIImageView(frame: CGRect(x: 16, y: 8, width: 40, height: 40))
        imageView.setImage(url: URL(string: self.person!.picture), duration: 0)
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 20
        self.footer.addSubview(imageView)
        
        let nameLabel = UILabel(frame: CGRect(x: 72, y: 8, width: self.view.frame.width - 72, height: 20))
        nameLabel.text = self.person!.first_name + " " + self.person!.last_name
        
        self.footer.addSubview(nameLabel)
        
        
        let emailLabel = UILabel(frame: CGRect(x: 72, y: 28, width: self.view.frame.width - 72, height: 20))
        emailLabel.text = self.person!.email
        
        self.footer.addSubview(emailLabel)
    }
    
    
    func setRegion(location: CLLocationCoordinate2D) {
        var region = MKCoordinateRegion()
        
        region.center = location
        
        region.span.latitudeDelta = 0.2
        region.span.longitudeDelta = 0.2
        
        self.mapView.setRegion(region, animated: true)
    }
    
    func addPin(location: CLLocationCoordinate2D) {
        let annotion = MKPointAnnotation()
        annotion.coordinate = location
        annotion.title = ""
        self.mapView.addAnnotation(annotion)
    }
}


extension PersonDetailViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: "annotion", for: annotation)
        
        annotationView.calloutOffset = CGPoint(x: 0, y: -5)
        let titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 40, height: 20))
        titleLabel.text = self.person!.first_name + " " + self.person!.last_name
        annotationView.canShowCallout = true
        annotationView.detailCalloutAccessoryView = titleLabel
        
        
        return annotationView
    }
}
