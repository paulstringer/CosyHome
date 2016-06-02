//
//  CreateTemperatureStates.swift
//  CosyHome
//
//  Created by Paul Stringer on 25/05/2016.
//  Copyright © 2016 stringerstheory. All rights reserved.
//

import Foundation

@objc(CreateTemperatureStates)

class CreateTemperatureStates : NSObject, SlimDecisionTable {
    
    var state = ""
    var temp = ""
    
    static var data = [String:Int]()
    
    func execute() {

        CreateTemperatureStates.data[state] = Int(temp)
        
    }

    
}