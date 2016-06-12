import Foundation

class TemperatureGatewaySimple : TemperatureGateway {
    
    var group: TemperatureSettingGroup
    var enabled = true
    
    convenience init() {
        
        self.init(slumber: 14, comfy:18, cosy:21)
        
    }
    
    init(slumber: Double, comfy: Double, cosy: Double) {
        
        self.group = TemperatureSettingGroup.groupWithTemperaturesSlumber(slumber, comfy: comfy, cosy: cosy)
        
    }
    
    func fetchGroup() -> TemperatureGatewayResponse {
        
        if !enabled {
            return .error
        } else {
            return .success(group: group)
        }
    }

    
}