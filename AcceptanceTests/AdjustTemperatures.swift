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