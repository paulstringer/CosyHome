import Foundation

@objc(CreateTemperatureStates)

class CreateTemperatureStates : NSObject, SlimDecisionTable {
    
    var state = ""
    var temp = ""
    
    private static var data = [TemperatureSettingEntity]()
    
    
    func beginTable() {
    
        CreateTemperatureStates.data.removeAll()
        
    }
    
    func execute() {

        let type = TemperatureSettingEntityType(rawValue: state.uppercaseString)!
        
        let entity = TemperatureSettingEntity(type: type, temperature: Double(temp)!, minimum: 0.0, maximum: 0.0)

        CreateTemperatureStates.data.append(entity)
        
    }
    
    class var gateway : TemperatureSettingEntityGateway {
        
        get {
            
            return TemperatureSettingEntityGatewaySimple(entities: data)
            
        }
    }
    
}