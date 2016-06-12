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
    
    private var model: TemperatureGroupModel
    
    var settings: (slumber: TemperatureSettingEntity, comfy: TemperatureSettingEntity, cosy: TemperatureSettingEntity) {
        
        get {
        
            return TemperatureSettingEntity.entitiesWithSlumber(model.slumber, comfy: model.comfy, cosy: model.cosy)
        }
    }
    
    //MARK: Initialisation
    
    init() {
        self.init(slumber: 14, comfy: 19, cosy: 21)
    }
    
    init(slumber: Double, comfy: Double, cosy: Double) {
        
        self.model = TemperatureGroupModel(slumber: slumber, comfy: comfy, cosy: cosy)
        
    }
    
    init(temperatures: TemperatureGroupModel) {
        
        self.model = temperatures
        
    }
    
    //MARK: Business Logic 
    
    mutating func adjustTemperatureWithType(type: TemperatureGroupSettingType, to temperature: Double) {
        
        switch type {
            
        case .Slumber:
            
            model.slumber = temperature
            
        case .Comfy:
            
            model.comfy = temperature
            
        case .Cosy:
            
            model.cosy = temperature
        }
        
    }
    
}
