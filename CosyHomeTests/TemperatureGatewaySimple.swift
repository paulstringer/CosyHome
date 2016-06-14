import Foundation

class TemperatureGatewaySimple : TemperatureGateway {
    
    var group: TemperatureGroupEntity
    var enabled = true
    
    convenience init() {
        
        let temperatures = TemperatureGroupModel(low: 14, middle: 18, high: 21)
        
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