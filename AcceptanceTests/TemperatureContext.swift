//
//  TemperatureContext.swift
//  CosyHome
//
//  Created by Paul Stringer on 09/06/2016.
//  Copyright © 2016 stringerstheory. All rights reserved.
//

import Foundation

struct TemperatureContext: TemperatureSettingsDisplay {
    
    static var interactor: TemperatureSettingsInteractor?
    
    static var slumber: TemperatureSettingItem?
    static var comfy: TemperatureSettingItem?
    static var cosy: TemperatureSettingItem?
    
    init(slumber: Double, comfy: Double, cosy: Double) {
        
        let gateway = TemperatureSettingEntityGatewaySimple(slumber: slumber, comfy: comfy, cosy: cosy)
        
        let output = TemperatureSettingsPresenter(display: self)
        
        TemperatureContext.interactor = TemperatureSettingsInteractor(gateway: gateway, output: output)
        
        TemperatureContext.interactor?.start()
    }
    
    var slumber: TemperatureSettingItem? {
        set {
            TemperatureContext.slumber = newValue
        }
        
        get {
            return TemperatureContext.slumber
        }
    }
    
    var comfy: TemperatureSettingItem? {
        set {
            TemperatureContext.comfy = newValue
        }
        
        get {
            return TemperatureContext.comfy
        }
    }
    
    var cosy: TemperatureSettingItem? {
        set {
            TemperatureContext.cosy = newValue
        }
        
        get{
            return TemperatureContext.cosy
        }
    }
    
}