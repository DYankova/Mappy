//
//  LocationModel.swift
//  Mappy
//
//  Created by Didi on 17.02.20.
//  Copyright © 2020 DroneSense. All rights reserved.
//

import UIKit
import MapKit

struct LocationModel {

    let coordinates : CLLocationCoordinate2D
      
    init(_ coordinates: CLLocationCoordinate2D) {
        self.coordinates = coordinates
    }
}
