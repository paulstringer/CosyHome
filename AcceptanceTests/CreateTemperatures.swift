import Foundation

@objc(CreateTemperatures)

class CreateTemperatures : NSObject, SlimDecisionTable {
    
    var state = ""
    var temp = "0"

    private static var context: TemperatureContext?
    private static var temps = [String:Double]()
    
    func beginTable() {
        
        CreateTemperatures.temps.removeAll()
        
    }
    
    func execute() {

        CreateTemperatures.temps[state] = Double(temp)!
        
    }
    
    func endTable() {
        
        let slumberTemp = CreateTemperatures.temps["Slumber"] ?? 0
        let comfyTemp = CreateTemperatures.temps["Comfy"] ?? 0
        let cosyTemp = CreateTemperatures.temps["Cosy"] ?? 0
            
        CreateTemperatures.context = TemperatureContext(slumber: slumberTemp, comfy: comfyTemp, cosy: cosyTemp)
        
    }
    
}