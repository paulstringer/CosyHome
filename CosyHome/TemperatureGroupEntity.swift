
import Foundation

private struct TemperatureModel {
    var slumber: Double
    var cosy: Double
    var comfy: Double
}

struct TemperatureGroupEntity{
    
    private var temperatures: TemperatureModel
    
    var settings: (slumber: TemperatureGroupItemEntity, comfy: TemperatureGroupItemEntity, cosy: TemperatureGroupItemEntity) {
        
        get {
        
            return TemperatureGroupItemEntity.entitiesForSlumber(temperatures.slumber, comfy: temperatures.comfy, cosy: temperatures.cosy)
        }
    }

    init(slumber: Double, comfy: Double, cosy: Double) {
        
        self.temperatures = TemperatureModel(slumber: slumber, cosy: cosy, comfy: comfy)
        
    }
    
    //MARK: Business Logic 
    
    mutating func adjustTemperatureWithType(type: TemperatureGroupItemEntityType, to temperature: Double) {
        
        switch type {
            
        case .Slumber:
            
            temperatures.slumber = temperature
            
        case .Comfy:
            
            temperatures.comfy = temperature
            
        case .Cosy:
            
            temperatures.cosy = temperature
        }
        
    }
    
    //MARK: Factory Creation
    
    static func groupWithTemperaturesSlumber(slumber: Double, comfy: Double, cosy: Double ) -> TemperatureGroupEntity {
        
        return TemperatureGroupEntity(slumber: slumber, comfy: comfy, cosy: cosy)
        
    }
    
    
}
