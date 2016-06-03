import Foundation

@objc(CreateTemperatureStates)

class CreateTemperatureStates : NSObject, SlimDecisionTable {
    
    var state = ""
    var temp = "0"

    private static var temps = [String:Double]()
    
    func beginTable() {
        
        CreateTemperatureStates.temps.removeAll()
        
    }
    
    func execute() {

        CreateTemperatureStates.temps[state] = Double(temp)!
        
    }
    
    class var gateway : TemperatureSettingEntityGateway {
        
        get {
            
            guard
                let slumberTemp = temps["Slumber"],
                let comfyTemp = temps["Comfy"],
                let cosyTemp = temps["Cosy"] else {
                    return TemperatureSettingEntityGatewaySimple()
            }
            
            return TemperatureSettingEntityGatewaySimple(slumber: slumberTemp, comfy: comfyTemp, cosy: cosyTemp)
        }
        
    }
    
}