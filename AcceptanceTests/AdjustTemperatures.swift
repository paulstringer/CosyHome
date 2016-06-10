//
//  AdjustTemperatures.swift
//  CosyHome
//
//  Created by Paul Stringer on 10/06/2016.
//  Copyright © 2016 stringerstheory. All rights reserved.
//

import Foundation

@objc(AdjustTemperatures)

class AdjustTemperatures : NSObject, SlimDecisionTable {
    
    // MARK: DT Inputs
    
    var state = ""
    var temp = "0"
    
    func execute() {
        
        let temperature = Double(self.temp) ?? 0.0
        
        switch state {
        case "Slumber":
            TemperatureContext.interactor?.adjustSlumber( temperature )
        case "Comfy":
            TemperatureContext.interactor?.adjustComfy( temperature )
        case "Cosy":
            TemperatureContext.interactor?.adjustCosy( temperature )
        default:
            return
        }
        
    }
    
    
}