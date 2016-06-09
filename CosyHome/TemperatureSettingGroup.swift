
import Foundation

private struct TemperatureModel {
    var slumber: Double
    var cosy: Double
    var comfy: Double
}

struct TemperatureSettingGroup {
    
    private var temperatures: TemperatureModel
    
    var settings: (slumber: TemperatureSettingEntity, comfy: TemperatureSettingEntity,cosy: TemperatureSettingEntity) {
        
        get {
        
            return TemperatureSettingEntity.entitiesForSlumber(temperatures.slumber, comfy: temperatures.comfy, cosy: temperatures.cosy)
        }
    }

    init(slumber: Double, comfy: Double, cosy: Double) {
        
        self.temperatures = TemperatureModel(slumber: slumber, cosy: cosy, comfy: comfy)
        
    }
    
    mutating func adjustTemperatureWithType(type: TemperatureSettingEntityType, to temperature: Double) {
        
        switch type {
            
        case .Slumber:
            
            temperatures.slumber = temperature
            
        case .Comfy:
            
            temperatures.comfy = temperature
            
        case .Cosy:
            
            temperatures.cosy = temperature
        }
        
    }
    
    static func groupWithTemperaturesSlumber(slumber: Double, comfy: Double, cosy: Double ) -> TemperatureSettingGroup {
        
        return TemperatureSettingGroup(slumber: slumber, comfy: comfy, cosy: cosy)
        
    }
    
    
}
