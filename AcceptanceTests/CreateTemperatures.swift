import Foundation



@objc(CreateTemperatures)

class CreateTemperatures : NSObject, SlimDecisionTable {
    
    // Fixture Inputs
    
    var state = ""
    var temp = "0"
    
    // Fixture Input Storage
    
    private var temperatureValues = [String:Double]()

    // Decision Table
    
    func execute() {

        temperatureValues[state] = Double(temp)!
        
    }
    
    func endTable() {
        
        _ = TemperatureContext(temperatures: temperatures)
        
    }
    
    lazy private var temperatures: TemperatureContextInput = {
        
        let slumber = self.temperatureValues["Slumber"] ?? 0
        let comfy = self.temperatureValues["Comfy"] ?? 0
        let cosy = self.temperatureValues["Cosy"] ?? 0
        
        return (slumber, comfy, cosy)
        
    }()
    
}