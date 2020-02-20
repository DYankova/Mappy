//
//  LocationViewModel.swift
//  Mappy
//
//  Created by Didi on 17.02.20.
//  Copyright © 2020 DroneSense. All rights reserved.
//

import UIKit

class LocationViewModel {

    let locationModel: LocationModel

    init(_ locationModel: LocationModel) {
           self.locationModel = locationModel
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var longitude: Double {
        return roundCoordinates(Double(locationModel.coordinates.longitude))
    }
    
    var latitude: Double {
         return roundCoordinates(Double(locationModel.coordinates.latitude))
    }
    
    var currentCoordinateText: String {
        return " Location:  \n Lat:   \(latitude) \n Lng:  \(longitude)"
    }
    
    var previousCoordinateText: String {
        return " Previous:  \n Lat:   \(latitude) \n Lng:  \(longitude)"
    }
    
    private func roundCoordinates(_ coordinate: Double) ->  Double {
        return Double(round(10000 * coordinate)/10000)
    }
    
}
