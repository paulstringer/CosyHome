import Foundation

class TemperatureSettingEntityGatewaySimple : TemperatureSettingEntityGateway {
    
    var entities = [TemperatureSettingEntity]()
    var enabled = true
    
    convenience init(entities: [TemperatureSettingEntity]) {
        
        self.init()
        
        self.entities = entities
        
    }
    
    func fetchAll() -> TemperatureSettingEntityGatewayResponse {
        
        if !enabled {
            return .error
        } else {
            return .success(entities: entities)
        }
        
    }

    
}