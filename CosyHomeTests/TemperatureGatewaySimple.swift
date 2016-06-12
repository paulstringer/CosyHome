import Foundation

class TemperatureGatewaySimple : TemperatureGateway {
    
    var group: TemperatureGroupEntity
    var enabled = true
    
    convenience init() {
        
        let temperatures = TemperatureGroupModel(slumber: 14, comfy: 18, cosy: 21)
        
        self.init(temperatures:  temperatures)
        
    }
    
    init(temperatures: TemperatureGroupModel) {
        
        self.group = TemperatureGroupEntity(temperatures: temperatures)
        
    }
    
    func fetchGroup() -> TemperatureGatewayResponse {
        
        if !enabled {
            return .error
        } else {
            return .success(group: group)
        }
    }

    
}