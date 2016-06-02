//
//  TemperatureRangeDisplay.swift
//  CosyHome
//
//  Created by Paul Stringer on 25/05/2016.
//  Copyright © 2016 stringerstheory. All rights reserved.
//

import Foundation

struct TemperatureSettingItem: Equatable {
    let temp: String
    let minimum: String
    let maximum: String
}

func ==(lhs: TemperatureSettingItem, rhs: TemperatureSettingItem ) -> Bool {
    return lhs.temp == rhs.temp
}

protocol TemperatureSettingsDisplay {
    
    func setTemperatureSettings(settings:[TemperatureSettingItem])
    
}