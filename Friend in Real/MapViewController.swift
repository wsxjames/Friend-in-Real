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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        
        //        var placesClient: GMSPlacesClient!
                
                // Do any additional setup after loading the view.
                
                
                let urlString="https://api.yelp.com/v3/businesses/north-india-restaurant-san-francisco"
        
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
                            let business=try JSONDecoder().decode(Business.self, from: data!)
                            print(business.lat)
                            self.lat=business.lat
                            self.long=business.long
                            self.annotation.coordinate=CLLocationCoordinate2D(latitude: self.lat, longitude: self.long)
                            self.annotation.title="the White House"
                            self.annotation.subtitle="Trump's home"
                            let region=MKCoordinateRegion(center: self.annotation.coordinate, latitudinalMeters: 500, longitudinalMeters: 500)
                            self.mapView.addAnnotation(self.annotation)
                            self.mapView.setRegion(region, animated: true)
                            self.mapView.delegate=self
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
//           let region=MKCoordinateRegion(center: annotation.coordinate, latitudinalMeters: 5000000, longitudinalMeters: 5000000)
//                   mapView.setRegion(region, animated: true)
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

//        myView.
        annotationView.detailCalloutAccessoryView=ButtonView
//        annotationView.detailCalloutAccessoryView=myView
//        annotationView.detailCalloutAccessoryView=UIImageView(image: UIImage(named:"sample"))
        return annotationView

        
    }
}
class SnapshotAnnotationView: MKPinAnnotationView {
    override var annotation: MKAnnotation? { didSet { configureDetailView() } }

    override init(annotation: MKAnnotation?, reuseIdentifier: String?) {
        super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)
        configure()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configure()
    }
}

private extension SnapshotAnnotationView {
    func configure() {
        canShowCallout = true
        configureDetailView()
    }

    func configureDetailView() {
        guard let annotation = annotation else { return }

        let rect = CGRect(origin: .zero, size: CGSize(width: 300, height: 200))

        let snapshotView = UIView()
        snapshotView.translatesAutoresizingMaskIntoConstraints = false

        let options = MKMapSnapshotter.Options()
        options.size = rect.size
        options.mapType = .satelliteFlyover
        options.camera = MKMapCamera(lookingAtCenter: annotation.coordinate, fromDistance: 250, pitch: 65, heading: 0)

        let snapshotter = MKMapSnapshotter(options: options)
        snapshotter.start { snapshot, error in
            guard let snapshot = snapshot, error == nil else {
                print(error ?? "Unknown error")
                return
            }

            let imageView = UIImageView(frame: rect)
            imageView.image = snapshot.image
            snapshotView.addSubview(imageView)
        }

        detailCalloutAccessoryView = snapshotView
        NSLayoutConstraint.activate([
            snapshotView.widthAnchor.constraint(equalToConstant: rect.width),
            snapshotView.heightAnchor.constraint(equalToConstant: rect.height)
        ])
    }
}
