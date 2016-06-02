//
//  TemperaturePresenter.swift
//  CosyHome
//
//  Created by Paul Stringer on 25/05/2016.
//  Copyright © 2016 stringerstheory. All rights reserved.
//

import Foundation


class TemperatureSettingsPresenter: TemperatureSettingsInteractorOutput {
    
    let display: TemperatureSettingsDisplay
    
    init(display: TemperatureSettingsDisplay) {
        self.display = display
    }
    
    //MARK: Interactor Output
    
    func setTemperatures(temperatures: [TemperatureSetting]) {
        let items = temperatures.map { (setting) -> TemperatureSettingItem in
            return TemperatureSettingItem(temp: "\(0.0)", minimum: "", maximum: "")
        }
         display.setTemperatureSettings(items)
    }
}