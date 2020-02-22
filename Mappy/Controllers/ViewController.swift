//
//  ViewController.swift
//  Mappy
//
//  Created by Robert Shoemate on 10/22/19.
//  Copyright © 2019 DroneSense. All rights reserved.
//

import UIKit
import MapKit


class ViewController: UIViewController, UIGestureRecognizerDelegate {

    @IBOutlet weak var mapView: MKMapView!

    var locationViewModel: LocationViewModel!
    
    lazy var bottomBarView: BottomBarView = {
        let view = BottomBarView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var previousCoordsCollection = bottomBarView.previousCoordView.collectionView
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        addGestures()
    }
    
    private func setupViews() {
        view.addSubview(bottomBarView)
        
        bottomBarView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40).isActive = true
        bottomBarView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Constants.padding).isActive = true
        bottomBarView.heightAnchor.constraint(equalToConstant: Constants.viewHeight).isActive = true
        bottomBarView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: Constants.bottomBarPadding).isActive = true
    }
    
    private func addGestures(){
        let moveBarGesture = UIPanGestureRecognizer(target: self, action:  #selector(moveBottomBar))
        bottomBarView.addGestureRecognizer(moveBarGesture)
        moveBarGesture.delegate = self
        
        let selectCoordGesture = UITapGestureRecognizer(target: self, action: #selector(selectCoordinate))
        mapView.addGestureRecognizer(selectCoordGesture)
        mapView.delegate = self
    }
    
    @objc private func selectCoordinate(gestureRecognizer: UITapGestureRecognizer) {
        let allAnnotations = mapView.annotations
        mapView.removeAnnotations(allAnnotations)
        
        if locationViewModel != nil {
            addToPrevious(locationViewModel)
        }
        
        let location = gestureRecognizer.location(in: mapView)
        let coordinate = mapView.convert(location, toCoordinateFrom: mapView)
         
        let annotation = MKPointAnnotation()
        annotation.coordinate = coordinate
        mapView.addAnnotation(annotation)
        locationViewModel = LocationViewModel(LocationModel(coordinate))
        updateBottomBar()
    }
    
    private func updateBottomBar(){
        bottomBarView.currentCoordView.text = locationViewModel.currentCoordinateText
        previousCoordsCollection.reloadData()
    }
    
    @objc func moveBottomBar(_ gestureRecognizer: UIPanGestureRecognizer) {
        if gestureRecognizer.state == UIGestureRecognizer.State.began || gestureRecognizer.state == UIGestureRecognizer.State.changed {
            let translation = gestureRecognizer.translation(in: self.view)
            let maxY = view.frame.maxY
            if gestureRecognizer.view!.center.y < maxY {
                let y = (gestureRecognizer.view!.center.y + translation.y) > Constants.viewHeight ? gestureRecognizer.view!.center.y + translation.y : Constants.viewHeight
                gestureRecognizer.view!.center = CGPoint(x: gestureRecognizer.view!.center.x, y: y)
            } else {
                gestureRecognizer.view!.center = CGPoint(x: gestureRecognizer.view!.center.x, y: maxY)
            }
            gestureRecognizer.setTranslation(CGPoint(x: 0, y: 0), in: self.view)
        }
    }

    private func addToPrevious(_ locationViewModel: LocationViewModel){
        if GlobalVar.previousCoordinates.count == 3 {
            GlobalVar.previousCoordinates.removeFirst()
        }
            GlobalVar.previousCoordinates.append(locationViewModel)
            previousCoordsCollection.scrollToItem(at: IndexPath(row: 0, section: 0), at: .bottom,animated: true)
    }
    
  }

  extension ViewController: MKMapViewDelegate {
      
      func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
          guard annotation is MKPointAnnotation else { return nil }
      
          let reuseId = "pin"
          var pinView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseId) as? MKPinAnnotationView
          
          if pinView == nil {
              pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
              pinView!.pinTintColor = UIColor.red
          } else {
              pinView!.annotation = annotation
          }
          return pinView
      }
    
  }
