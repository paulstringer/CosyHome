//
//  TemperatureRanges.swift
//  CosyHome
//
//  Created by Paul Stringer on 25/05/2016.
//  Copyright © 2016 stringerstheory. All rights reserved.
//

import Foundation

@objc(CheckTemperatures)

class CheckTemperatures : NSObject, SlimDecisionTable {

    // MARK: DT Inputs
    
    var state = ""
    
    // MARK: DT Outputs
    
    var temp: String {
        
        get {
        
            return setting?.temp ?? "\(state) Not Found"
            
        }
        
    }
    
    var minimum: String {
        
        get {
            
            return setting?.minimum ?? "\(state) Not Found"

        }
        
    }
    
    var maximum: String {
        get {
           
            return setting?.maximum ?? "\(state) Not Found"
            
        }
    }
    
    var setting: TemperatureSettingItem? {
        
        get {
            switch state {
            case "Slumber":
                return TemperatureContext.slumber
            case "Comfy":
                return TemperatureContext.comfy
            case "Cosy":
                return TemperatureContext.cosy
            default:
                return nil
            }
        }
        
    }

    
    func execute() {
        // ...
    }
    
}

