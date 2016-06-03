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
            
            guard let slumber = temps["Slumber"],
                let comfy = temps["Comfy"],
                let cosy = temps["Cosy"] else {
            
                    return TemperatureSettingEntityGatewaySimple()
            }
            
            
            let entities = TemperatureSettingEntity.entitiesWithTemperatureForSlumber(slumber, comfy: comfy, cosy: cosy)
            
            return TemperatureSettingEntityGatewaySimple(entities: entities)
        }
        
    }
    
}