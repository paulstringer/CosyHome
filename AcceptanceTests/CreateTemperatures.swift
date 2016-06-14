import Foundation

@objc(CreateTemperatures)

class CreateTemperatures : NSObject, SlimDecisionTable {
    
    // Fixture Inputs
    
    var state: String = ""
    
    var temperature = "0"
    
    // Fixture Input Storage
    
    private var temperatureValues = [FixtureTemperatureState:Double]()

    // Decision Table
    
    func execute() {
        
        if let key = FixtureTemperatureState(rawValue: state), let value = Double(temperature) {
            
            temperatureValues[key] = value
            
        }
        
    }
    
    func endTable() {
        
        _ = TemperatureContext(temperatures: temperatures)
        
    }
    
    lazy private var temperatures: TemperatureContextInput = {
        
        let slumber = self.temperatureValues[.low] ?? 0
        let comfy = self.temperatureValues[.middle] ?? 0
        let cosy = self.temperatureValues[.high] ?? 0
        
        return (slumber, comfy, cosy)
        
    }()
    
}