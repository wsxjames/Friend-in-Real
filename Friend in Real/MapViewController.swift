//
//  ViewController.swift
//  playground
//
//  Created by 吴世欣 on 3/15/20.
//  Copyright © 2020 James Wu. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController, MKMapViewDelegate {
    
    @IBOutlet var mapView: MKMapView!
    var lat: Double = 0.0
    var long: Double = 0.0
    let annotation=MKPointAnnotation()
    @IBOutlet var ButtonView: UIView!
    @IBOutlet var buttonViewLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        
        //        var placesClient: GMSPlacesClient!
        
        // Do any additional setup after loading the view.
        annotateMap()
        

    }
    
    
    
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation is MKUserLocation {
            return nil
        }
        
        let annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: "customannotation")
        annotationView.image = UIImage(named:"pin")
        annotationView.canShowCallout = true
        //        let leftIconView = UIImageView(frame: CGRect.init(x: 0, y: 0, width: 53, height: 53))
        //        leftIconView.image = UIImage(named: "sample")
        //        let rightIconView = UIImageView(frame: CGRect.init(x: 0, y: 0, width: 53, height: 53))
        //        rightIconView.image = UIImage(named: "sample")
        //        annotationView.leftCalloutAccessoryView = leftIconView
        //        let rightView: UIView={
        //            let view=UIView(frame: CGRect(x:0,y:0,width:50,height:50))
        ////            let label = UILabel(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
        ////            label.center = CGPoint(x: 160, y: 285)
        ////            label.textAlignment = .center
        ////            label.text = "I'm a test label"
        //            view.backgroundColor = .red
        ////            self.view.addSubview(label)
        //            return view
        //        }()
        //        annotationView.rightCalloutAccessoryView=rightView
        //        print ("----------test-----------")
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
        let lng : NSNumber = NSNumber(value: location.longitude)
        self.buttonViewLabel.text="\(lat),\(lng)"
    }
    
    func annotateMap(){
//        let urlString="https://api.yelp.com/v3/businesses/north-india-restaurant-san-francisco"
        let urlString="https://api.yelp.com/v3/businesses/search?term=restaurant&latitude=37.786882&longitude=-122.399972"
        
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
                    let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers)
                    print(json)
                    let business=try JSONDecoder().decode([RawServerResponse].self, from: data!)
//                    print(business.lat)
//                    self.lat=business.lat
//                    self.long=business.long
//                    self.annotation.coordinate=CLLocationCoordinate2D(latitude: self.lat, longitude: self.long)
//                    self.annotation.title="the White House"
//                    self.annotation.subtitle="Trump's home"
//                    let region=MKCoordinateRegion(center: self.annotation.coordinate, latitudinalMeters: 500, longitudinalMeters: 500)
//                    self.mapView.addAnnotation(self.annotation)
//                    self.mapView.setRegion(region, animated: true)
//                    self.mapView.delegate=self
                    //                            self.mapView.register(SnapshotAnnotationView.self, forAnnotationViewWithReuseIdentifier: MKMapViewDefaultAnnotationViewReuseIdentifier)
                    
                }catch let jsonErr{
                    print(jsonErr)
                }
            }
            dataTask.resume()
        }
        
        print("finished")
        
        
        //        let annotation=MKPointAnnotation()
        //           annotation.coordinate=CLLocationCoordinate2D(latitude: 37, longitude: -77)
        //           annotation.title="the White House"
        //           annotation.subtitle="Trump's home"
        //           mapView.addAnnotation(annotation)
        //           mapView.delegate=self
        //
        //         let annotation2=MKPointAnnotation()
        //        annotation2.coordinate=CLLocationCoordinate2D(latitude: 37.2, longitude: -77.2)
        //        annotation2.title="the White House2"
        //        annotation2.subtitle="Trump's home2"
        //        mapView.addAnnotation(annotation2)
        //        mapView.delegate=self
        //
        //           let region=MKCoordinateRegion(center: annotation.coordinate, latitudinalMeters: 500, longitudinalMeters: 500)
        //                   mapView.setRegion(region, animated: true)
    }
}
