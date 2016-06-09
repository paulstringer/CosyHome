//
//  TemperatureRanges.swift
//  CosyHome
//
//  Created by Paul Stringer on 25/05/2016.
//  Copyright © 2016 stringerstheory. All rights reserved.
//

import Foundation

@objc(CheckTemperatures)

class CheckTemperatures : NSObject, SlimDecisionTable, TemperatureSettingsDisplay {
    
    // MARK: System Under Test Creation
    
    lazy var systemUnderTest : TemperatureSettingsInteractor  = {
            
            let gateway = CreateTemperatures.gateway
            
            let output = TemperatureSettingsPresenter(display: self)
            
            return TemperatureSettingsInteractor(gateway: gateway, output: output)
        
//        guard let interactor = TemperatureContext.interactor else {
//            
//            fatalError()
//            
//        }
//        
//        return interactor
        
    }()
    
    // MARK: System Under Test Outputs
    
    var slumber: TemperatureSettingItem?
    var comfy: TemperatureSettingItem?
    var cosy: TemperatureSettingItem?
    
    // MARK: DT Inputs
    
    var state = ""
    
    // MARK: DT Outputs
    
    var temp: String {
        
        get {
        
            return temperatureForActiveState?.temp ?? "\(state) Not Found"
            
        }
        
    }
    
    var minimum: String {
        
        get {
            
            return temperatureForActiveState?.minimum ?? "\(state) Not Found"

        }
        
    }
    
    var maximum: String {
        get {
           
            return temperatureForActiveState?.maximum ?? "\(state) Not Found"
            
        }
    }
    
    func execute() {

        systemUnderTest.start()
        
    }
    
    var temperatureForActiveState: TemperatureSettingItem? {
        
        get {
            switch state {
            case "Slumber":
                return slumber
            case "Comfy":
                return comfy
            case "Cosy":
                return cosy
            default:
                return nil
            }
        }
        
    }

    
}


@objc(AdjustTemperatures)

class AdjustTemperatures : NSObject, SlimDecisionTable, TemperatureSettingsDisplay {
    
    // MARK: System Under Test Creation
    
    lazy var systemUnderTest : TemperatureSettingsInteractor  = {
        
        let gateway = CreateTemperatures.gateway
        
        let output = TemperatureSettingsPresenter(display: self)
        
        return TemperatureSettingsInteractor(gateway: gateway, output: output)
        
    }()
    
    // MARK: System Under Test Outputs
    
    var slumber: TemperatureSettingItem?
    var comfy: TemperatureSettingItem?
    var cosy: TemperatureSettingItem?
    
    // MARK: DT Inputs
    
    var state = ""
    var temp = "0"
    
    func  execute() {
        
        let temperature = Double(self.temp) ?? 0.0
        
        switch state {
        case "Slumber":
            return systemUnderTest.adjustSlumber( temperature )
        case "Comfy":
            return systemUnderTest.adjustComfy( temperature )
        case "Cosy":
            return systemUnderTest.adjustCosy( temperature )
        default:
            return
        }
        
    }
    
    
}