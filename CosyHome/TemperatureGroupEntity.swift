import Foundation

struct TemperatureGroupModel {
    var slumber: Double
    var comfy: Double
    var cosy: Double
}


enum TemperatureGroupSettingType {
    case Slumber
    case Comfy
    case Cosy
}

struct TemperatureGroupEntity{
    
    private var t: TemperatureGroupModel
    
    var settings: (slumber: TemperatureSettingEntity, comfy: TemperatureSettingEntity, cosy: TemperatureSettingEntity) {
        
        get {
        
            return TemperatureSettingEntity.entitiesWithSlumber(t.slumber, comfy: t.comfy, cosy: t.cosy)
        }
    }
    
    init() {
        self.init(slumber: 14, comfy: 19, cosy: 21)
    }
    
    init(slumber: Double, comfy: Double, cosy: Double) {
        
        self.t = TemperatureGroupModel(slumber: slumber, comfy: comfy, cosy: cosy)
        
    }
    
    init(temperatures: TemperatureGroupModel) {
        
        self.t = temperatures
        
    }
    
    //MARK: Business Logic 
    
    mutating func adjustTemperatureWithType(type: TemperatureGroupSettingType, to temperature: Double) {
        
        switch type {
            
        case .Slumber:
            
            t.slumber = temperature
            
        case .Comfy:
            
            t.comfy = temperature
            
        case .Cosy:
            
            t.cosy = temperature
        }
        
    }
    
}
