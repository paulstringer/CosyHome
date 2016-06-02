//
//  TemperatureSettingsInteractorOutput.swift
//  CosyHome
//
//  Created by Paul Stringer on 25/05/2016.
//  Copyright © 2016 stringerstheory. All rights reserved.
//

import Foundation

protocol TemperatureSettingsInteractorOutput {
    
    func setTemperatures(temperatures: [TemperatureSetting])
    
}



protocol TemperatureSettingsInteractorInput {
    
    func incrementTemperature(state: String);
    func decrementTemperature(state: String);
    
}


struct TemperatureSetting: Equatable {
    let temp: Double
    let minimum: Double
    let maximum: Double
}

func ==(lhs: TemperatureSetting, rhs: TemperatureSetting ) -> Bool {
    return lhs.temp == rhs.temp
}
