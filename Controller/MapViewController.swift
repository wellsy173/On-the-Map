//
//  MapViewController.swift
//  On The Map
//
//  Created by Simon Wells on 2020/8/13.
//  Copyright © 2020 Simon Wells. All rights reserved.
//

import Foundation
import UIKit
import MapKit

class MapViewController: UIViewController, MKMapViewDelegate {
    
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var pinDrop: UIBarButtonItem!
    @IBOutlet weak var refresh: UIBarButtonItem!
    @IBOutlet weak var addLocation: UIBarButtonItem!
    
    var locations = [StudentInformation]()
    var annotations = [MKPointAnnotation]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidAppear(true)
    }
    
    
    @IBAction func addLocation(_ sender: Any) {
        performSegue(withIdentifier: "addLocation", sender: sender)
          }
    
    func getStudentPins() {
        self.mapView.removeAnnotations(self.annotations)
        self.annotations.removeAll()
        self.locations = locations ?? []
        for dictionary in locations ?? [] {
            let lat = CLLocationDegrees(dictionary.latitude ?? 0.0)
            let long = CLLocationDegrees(dictionary.longitude ?? 0.0)
            let coordinate = CLLocationCoordinate2D(latitude: lat, longitude: long)
            let firstName = dictionary.firstName
            let lastName = dictionary.lastName
            let mediaURL = dictionary.mediaURL
            let annotation = MKPointAnnotation()
            annotation.coordinate = coordinate
            annotation.title = "\(firstName) \(lastName)"
            annotation.subtitle = mediaURL
            self.annotations.append(annotation)
        }
        DispatchQueue.main.async {
            self.mapView.addAnnotation(self.annotations as! MKAnnotation)
        }
}
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let reuseId = "pin"
        var pinView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseId) as? MKPinAnnotationView
        if pinView == nil {
            pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
            pinView!.canShowCallout = true
            pinView!.pinTintColor = .blue
            pinView?.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
            
        }
        else {
            pinView!.annotation = annotation
        }
        return pinView
        }
    
    func mapView(_ _mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        if control == view.rightCalloutAccessoryView {
            if let open = view.annotation?.subtitle {
                openLink(open ?? "")
            }
        }
    }
        
    }
