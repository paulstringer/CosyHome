import Foundation

@objc(AdjustTemperatures)

class AdjustTemperatures : NSObject, SlimDecisionTable {
    
    // MARK: DT Inputs
    
    var state = FixtureTemperatureState.undefined.rawValue
    var temperature = "0"
    
    func execute() {
        
        let temperature = Double(self.temperature) ?? 0.0
        
        if let adjustment = FixtureTemperatureState(rawValue: state) {

            switch adjustment {
                
            case .slumber:
                TemperatureContext.interactor?.request(.adjustSlumber( temperature: temperature ) )
                
            case .comfy:
                TemperatureContext.interactor?.request(.adjustComfy( temperature: temperature ) )
                
            case .cosy:
                TemperatureContext.interactor?.request(.adjustCosy( temperature: temperature ) )
                
            case .undefined:
                return
                
            }
            
        }
        
    }
    
    
}