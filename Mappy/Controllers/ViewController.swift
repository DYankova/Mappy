//
//  ViewController.swift
//  Mappy
//
//  Created by Robert Shoemate on 10/22/19.
//  Copyright © 2019 DroneSense. All rights reserved.
//

import UIKit
import MapKit

struct GlobalVar {
    static var previousCoordinates = [LocationViewModel]()
}


class ViewController: UIViewController, UIGestureRecognizerDelegate {

    @IBOutlet weak var mapView: MKMapView!

    var locationViewModel: LocationViewModel!
    
    lazy var bottomBarView: BottomBarView = {
        let view = BottomBarView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(bottomBarView)
        bottomBarView.layer.cornerRadius = 70
        setUpViews()
     
      let gesture = UIPanGestureRecognizer(target: self, action:  #selector(wasDragged))
        bottomBarView.addGestureRecognizer(gesture)
        gesture.delegate = self
        
        mapView.delegate = self
        let longTapGesture = UITapGestureRecognizer(target: self, action: #selector(longTap))
        mapView.addGestureRecognizer(longTapGesture)
    }
    
    @objc func longTap(gestureRecognizer: UILongPressGestureRecognizer) {
        let allAnnotations = mapView.annotations
        mapView.removeAnnotations(allAnnotations)
        let location = gestureRecognizer.location(in: mapView)
        print(location)
        let coordinate = mapView.convert(location, toCoordinateFrom: mapView)
         
        let annotation = MKPointAnnotation()
        annotation.coordinate = coordinate
        mapView.addAnnotation(annotation)
        print(coordinate)
        
        locationViewModel = LocationViewModel(LocationModel(coordinate))
        bottomBarView.currentCoordView.text = locationViewModel.currentCoordinateText
        addToPrevious(locationViewModel)
        
        bottomBarView.previousCoordView.collectionView.reloadData()
  }
    
    @objc func wasDragged(_ gestureRecognizer: UIPanGestureRecognizer) {
        if gestureRecognizer.state == UIGestureRecognizer.State.began || gestureRecognizer.state == UIGestureRecognizer.State.changed {

            let translation = gestureRecognizer.translation(in: self.view)
            print(gestureRecognizer.view!.center.y)

            if(gestureRecognizer.view!.center.y < 855) {
                gestureRecognizer.view!.center = CGPoint(x: gestureRecognizer.view!.center.x, y: gestureRecognizer.view!.center.y + translation.y)
            } else {
                gestureRecognizer.view!.center = CGPoint(x:gestureRecognizer.view!.center.x, y: 554)
            }
            gestureRecognizer.setTranslation(CGPoint(x: 0, y: 0), in: self.view)
        }
    }

    func addToPrevious(_ locationViewModel: LocationViewModel){
        if GlobalVar.previousCoordinates.count == 3 {
            GlobalVar.previousCoordinates.removeLast()
        }
            GlobalVar.previousCoordinates.append(locationViewModel)
    }
    
  }

  extension ViewController: MKMapViewDelegate{
      
      func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
          guard annotation is MKPointAnnotation else { print("no mkpointannotaions"); return nil }
      
          let reuseId = "pin"
          var pinView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseId) as? MKPinAnnotationView
          
          if pinView == nil {
              pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
              pinView!.pinTintColor = UIColor.red
          }
          else {
              pinView!.annotation = annotation
          }
          return pinView
      }

    
    func setUpViews(){
        bottomBarView.topAnchor.constraint(equalTo: view.topAnchor, constant: 500).isActive = true
//        bottomBarView.centerXAnchor.constrant(equalTo: view.centerXAnchor).isActive = true
        bottomBarView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        bottomBarView.heightAnchor.constraint(equalToConstant: 85).isActive = true
        bottomBarView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
    }
    
  }
