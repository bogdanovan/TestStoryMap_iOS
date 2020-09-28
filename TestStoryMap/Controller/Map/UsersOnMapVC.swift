//
//  UsersOnMapVC.swift
//  TestStoryMap
//
//  Created by Anatolii Bogdanov on 23.09.2020.
//

import UIKit
import MapKit

class UsersOnMapVC: UIViewController {
    
    var users: [Users] {
        get {
            let navController = self.tabBarController!.viewControllers![0] as! UINavigationController
            let userVC = navController.viewControllers[0] as! UsersVC
            return userVC.users
        }
    }
    
    @IBOutlet weak var mapView: MKMapView!
    
    var usersWithLocation: [Users] = []
    var regionRadius: CLLocationDistance = 1000
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapView.delegate = self
        
        self.navigationItem.title = K.userOnMapNavBarTitle
        displayUsers()
    }
    
    
    func displayUsers() {
        for user in users {
            if let lat = user.lat, let lon = user.lon {
                loadAnnotations(user: user, lat: lat, lon: lon)
            }
        }
    }
    
    
    func loadAnnotations(user: Users, lat: Double, lon: Double) {
        let request = NSMutableURLRequest(url: URL(string: user.avatar)!)
        request.httpMethod = "GET"
        
        let session = URLSession(configuration: URLSessionConfiguration.default)
        let dataTask = session.dataTask(with: request as URLRequest) { (data, response, error) in
            if error == nil {
                
                let annotation = UserAnnotation()
                annotation.coordinate = CLLocationCoordinate2DMake(lat, lon)
                annotation.image = UIImage(data: data!, scale: UIScreen.main.scale)
                annotation.title = user.name
                annotation.batteryColor = user.batteryColor
                annotation.batteryImage = user.batteryImage
                annotation.batteryPrecentage = user.batteryPercentage
                
                DispatchQueue.main.async {
                    self.mapView.addAnnotation(annotation)
                    let dortmunRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: lat, longitude: lon),
                                                           span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1))
                    self.mapView.setRegion(dortmunRegion, animated: true)
                }
            }
        }
        
        dataTask.resume()
    }
    
}

extension UsersOnMapVC: MKMapViewDelegate{
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        if annotation.isKind(of: MKUserLocation.self) {
            return nil
        }
        
        if !annotation.isKind(of: UserAnnotation.self) {
            var pinAnnotationView = mapView.dequeueReusableAnnotationView(withIdentifier: "DefaultPinView")
            if pinAnnotationView == nil {
                pinAnnotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: "DefaultPinView")
            }
            return pinAnnotationView
        }
        
        var view: LocationAnnotationView? = mapView.dequeueReusableAnnotationView(withIdentifier: K.customAnnotation) as? LocationAnnotationView
        if view == nil {
            view = LocationAnnotationView(annotation: annotation, reuseIdentifier: K.customAnnotation)
        }
        
        let annotation = annotation as! UserAnnotation
        view?.image = annotation.image
        view?.annotation = annotation
        
        return view
    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        guard let annotation = view.annotation else { return }
        let dortmunRegion = MKCoordinateRegion(center: annotation.coordinate,
                                               span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1))
        mapView.setRegion(dortmunRegion, animated: true)
    }
}
