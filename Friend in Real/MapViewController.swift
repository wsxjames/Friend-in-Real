//
//  ViewController.swift
//  playground
//
//  Created by 吴世欣 on 3/15/20.
//  Copyright © 2020 James Wu. All rights reserved.
//

import UIKit
import MapKit
import Firebase
//import FirebaseFirestore
import Firebase

class MapViewController: UIViewController, MKMapViewDelegate {
    
    @IBOutlet var mapView: MKMapView!
    var lat: Double = 0.0
    var long: Double = 0.0
    let db = Firestore.firestore()
    @IBOutlet var buttonViewButton: UIButton!
    
    
    @IBOutlet var ButtonView: UIView!
    @IBOutlet var buttonViewLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        annotateMap()
    }
    
    
    
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation is MKUserLocation {
            return nil
        }
        
        let annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: "customannotation")
        annotationView.image = UIImage(named:"pin")
        annotationView.canShowCallout = true
        let myView=UIView()
        myView.backgroundColor = .green
        let widthConstraint = NSLayoutConstraint(item: myView, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 40)
        myView.addConstraint(widthConstraint)
        
        let heightConstraint = NSLayoutConstraint(item: myView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 20)
        myView.addConstraint(heightConstraint)
        annotationView.detailCalloutAccessoryView=ButtonView
        return annotationView
        
        
    }
    
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        print(view.annotation!.coordinate)
        let location=view.annotation!.coordinate
        let lat : NSNumber = NSNumber(value: location.latitude)
        let long : NSNumber = NSNumber(value: location.longitude)
//        var data: Data
        
//        downloadImage(from: view.annotation!)
        self.buttonViewLabel.text="No"
        db.collection("Events").whereField("coordinates", isEqualTo: [lat,long]).getDocuments() { (querySnapshot, err) in
                if let err = err {
                    print("Error getting documents: \(err)")
                } else {
//                    for document in querySnapshot!.documents {
//
//                    }
//                    let data=querySnapshot!.documents[0].data()
//                    let name=data["name"] as? String ?? ""
                    
                    if(querySnapshot!.documents.count==0){
                        self.buttonViewButton.setTitle("Create One!", for: .normal)
                        
                    }else{
                        self.buttonViewLabel.text="Yes"
                        self.buttonViewButton.setTitle("Join!", for: .normal)
                    }
                }
        }
        
        
    }
    
    
    func annotateMap(){
        //        let urlString="https://api.yelp.com/v3/businesses/north-india-restaurant-san-francisco"
        let urlString="https://api.yelp.com/v3/businesses/search?term=cafe&latitude=37.786882&longitude=-122.399972"
        
        if let url = URL(string: urlString) {
            var request = URLRequest(url: url)
            let userToken="D0CEDc6gNhU0o1FISKWpYxczFP0Hpk7qjwkcHpt86D1fBP89tMJGUSafggiGOjRZhTToRBEnyvzpBFewzN8Z7Rj9Fe227LR6IKeegYOOR7EB8KhINKOVh6XNGs9tXnYx"
            //           request.addValue("D0CEDc6gNhU0o1FISKWpYxczFP0Hpk7qjwkcHpt86D1fBP89tMJGUSafggiGOjRZhTToRBEnyvzpBFewzN8Z7Rj9Fe227LR6IKeegYOOR7EB8KhINKOVh6XNGs9tXnYx", forHTTPHeaderField: "TRN-Api-Key")
            let tokenString = "Bearer " + userToken
            request.setValue(tokenString, forHTTPHeaderField: "Authorization")
            request.httpMethod = "GET"
            let dataTask = URLSession.shared.dataTask(with: request) { (data: Data?, response: URLResponse?, error: Error?) in
                //handle response here
                print ("hey")
                do {
//                    let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers)
                    //                    print(json)
                    let response=try JSONDecoder().decode(FinalResponse.self, from: data!)
                    
                    for b in response.businesses{
                        print(b.name)
                        let lat=b.coordinates.latitude
                        let long=b.coordinates.longitude
                        let annotation=MKPointAnnotation()
                        annotation.coordinate=CLLocationCoordinate2D(latitude: lat, longitude: long)
                        annotation.title=b.name
                        self.mapView.addAnnotation(annotation)
                        self.mapView.delegate=self
                        
                    }
                    let annotation=MKPointAnnotation()
                    annotation.coordinate=CLLocationCoordinate2D(latitude: 37.786882, longitude: -122.399972)
                    let region=MKCoordinateRegion(center: annotation.coordinate, latitudinalMeters: 500, longitudinalMeters: 500)
                    self.mapView.setRegion(region, animated: true)
                    
                    
                }catch let jsonErr{
                    print(jsonErr)
                }
            }
            dataTask.resume()
        }
        
        print("finished")
    }
    
    @IBAction func buttonViewButtonPressed(_ sender: Any) {
        if (buttonViewButton.titleLabel?.text=="Join!"){
            self.performSegue(withIdentifier: "join", sender: nil)
        }else{
            self.performSegue(withIdentifier: "create", sender: nil)
        }
//        self.performSegue(withIdentifier: "swipe", sender: nil)
    }
    
}
