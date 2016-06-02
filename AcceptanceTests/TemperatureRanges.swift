//
//  TemperatureRanges.swift
//  CosyHome
//
//  Created by Paul Stringer on 25/05/2016.
//  Copyright © 2016 stringerstheory. All rights reserved.
//

import Foundation


@objc(TemperatureRange)

class TemperatureRange : NSObject, SlimDecisionTable {
    
    var state = ""
    
    var temp = "17"
    
    var minimum: String {
        get {
            
            switch state {
            case "Slumber":
                    return "7"
            case "Comfy":
                    return "15"
            case "Cosy":
                    return "19"
            default:
                return "0"
            }

        }
    }
    
    var maximum: String {
        get {
            
            switch state {
            case "Slumber":
                return "17"
            case "Comfy":
                return "20"
            case "Cosy":
                return "30"
            default:
                return "0"
            }
            
        }
    }
    
    func execute() {
        // ...
        
        
    }
    
}