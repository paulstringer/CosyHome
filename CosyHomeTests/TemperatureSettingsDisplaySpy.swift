//
//  TemperatureRangeDisplaySpy.swift
//  CosyHome
//
//  Created by Paul Stringer on 25/05/2016.
//  Copyright © 2016 stringerstheory. All rights reserved.
//

import Foundation
@testable import CosyHome

class TemperatureSettingsDisplaySpy:  TemperatureSettingsDisplay{
    
    var settings: [TemperatureSettingItem]?
    
    func setTemperatureSettings(settings: [TemperatureSettingItem]) {
        self.settings = settings
    }
    
    
}