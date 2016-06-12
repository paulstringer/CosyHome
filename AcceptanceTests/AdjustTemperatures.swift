import Foundation

@objc(AdjustTemperatures)

class AdjustTemperatures : NSObject, SlimDecisionTable {
    
    // MARK: DT Inputs
    
    var state = FixtureTemperatureState.undefined.rawValue
    var temp = "0"
    
    func execute() {
        
        let temperature = Double(self.temp) ?? 0.0
        
        if let adjustment = FixtureTemperatureState(rawValue: state) {

            switch adjustment {
                
            case .slumber:
                TemperatureContext.interactor?.adjustSlumber( temperature )
                
            case .comfy:
                TemperatureContext.interactor?.adjustComfy( temperature )
                
            case .cosy:
                TemperatureContext.interactor?.adjustCosy( temperature )
                
            case .undefined:
                return
                
            }
            
        }
        
    }
    
    
}