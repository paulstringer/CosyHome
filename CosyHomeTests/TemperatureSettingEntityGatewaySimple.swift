import Foundation

class TemperatureSettingEntityGatewaySimple : TemperatureSettingEntityGateway {
    
    var entities = [TemperatureSettingEntity]()
    var enabled = true
    
    convenience init(slumber: Double, comfy: Double, cosy: Double) {
        
        self.init()
        
        self.entities = TemperatureSettingEntity.entitiesWithTemperatureForSlumber(slumber, comfy: comfy, cosy: cosy)
        
    }
    
    func fetchAll() -> TemperatureSettingEntityGatewayResponse {
        
        if !enabled {
            return .error
        } else {
            return .success(entities: entities)
        }
        
    }

    
}