//
//  GlobalVar.swift
//  Mappy
//
//  Created by Didi on 20.02.20.
//  Copyright © 2020 DroneSense. All rights reserved.
//

import UIKit

struct GlobalVar {
    static var previousCoordinates = [LocationViewModel]()

    func reversedNames() -> [LocationViewModel] {
        let reversedNames : [LocationViewModel] = Array(GlobalVar.previousCoordinates.reversed())
        return reversedNames
    }

    
}

