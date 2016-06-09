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
    
    var slumber: TemperatureSettingItem?
    var comfy: TemperatureSettingItem?
    var cosy: TemperatureSettingItem?
    
    init(slumber: Double, comfy: Double, cosy: Double) {
        
        let gateway = TemperatureSettingEntityGatewaySimple(slumber: slumber, comfy: comfy, cosy: cosy)
        
        let output = TemperatureSettingsPresenter(display: self)
        
        TemperatureContext.interactor = TemperatureSettingsInteractor(gateway: gateway, output: output)
    }
    
}