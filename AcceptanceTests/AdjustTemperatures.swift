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
                
            case .low:
                TemperatureContext.interactor?.request(.adjustSlumber( temperature: temperature ) )
                
            case .middle:
                TemperatureContext.interactor?.request(.adjustComfy( temperature: temperature ) )
                
            case .high:
                TemperatureContext.interactor?.request(.adjustCosy( temperature: temperature ) )
                
            case .undefined:
                return
                
            }
            
        }
        
    }
    
    
}