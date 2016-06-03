//
//  TemperatureRanges.swift
//  CosyHome
//
//  Created by Paul Stringer on 25/05/2016.
//  Copyright © 2016 stringerstheory. All rights reserved.
//

import Foundation

@objc(TemperatureRange)

class TemperatureRange : NSObject, SlimDecisionTable, TemperatureSettingsDisplay {
    
    var systemUnderTest : TemperatureSettingsInteractor!
    
    // MARK: DT Inputs
    
    var state = ""
    
    var temp: String {
        
        get {
        
            switch state {
            case "Slumber":
                return slumber?.temp ?? ""
            case "Comfy":
                return comfy?.temp ?? ""
            case "Cosy":
                return cosy?.temp ?? ""
            default:
                return "\(state) Not Found"
            }
        }
        
    }
    
    var minimum: String {
        get {
            
            switch state {
            case "Slumber":
                    return slumber?.minimum ?? ""
            case "Comfy":
                    return comfy?.minimum ?? ""
            case "Cosy":
                    return cosy?.minimum ?? ""
            default:
                return "\(state) Not Found"
            }

        }
    }
    
    var maximum: String {
        get {
            
            switch state {
            case "Slumber":
                return slumber?.maximum ?? ""
            case "Comfy":
                return comfy?.maximum ?? ""
            case "Cosy":
                return cosy?.maximum ?? ""
            default:
                return "\(state) Not Found"
            }
            
        }
    }
    
    func execute() {

        let gateway = CreateTemperatureStates.gateway
        
        let output = TemperatureSettingsPresenter(display: self)
        
        systemUnderTest = TemperatureSettingsInteractor(gateway: gateway, output: output)
        
        systemUnderTest.start()
        
    }
    
    //MARK: Display Outputs
    
    var slumber: TemperatureSettingItem?
    var comfy: TemperatureSettingItem?
    var cosy: TemperatureSettingItem?

    
}