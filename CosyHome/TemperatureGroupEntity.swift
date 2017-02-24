import Foundation

struct TemperatureGroupModel {
    var low: Double
    var middle: Double
    var high: Double
}

enum TemperatureGroupSettingType {
    case slumber
    case comfy
    case cosy
}

struct TemperatureGroupEntity{
    
    fileprivate var model: TemperatureGroupModel
    
    var settings: (low: TemperatureSettingEntity, middle: TemperatureSettingEntity, high: TemperatureSettingEntity) {
        
        get {
        
            return TemperatureSettingEntity.entitiesWithTemperaturesLow(model.low, middle: model.middle, high: model.high)
        }
    }
    
    //MARK: Initialisation
    
    init() {
        self.init(low: 14, middle: 19, high: 21)
    }
    
    init(low: Double, middle: Double, high: Double) {
        
        self.model = TemperatureGroupModel(low: low, middle: middle, high: high)
        
    }
    
    init(temperatures: TemperatureGroupModel) {
        
        self.model = temperatures
        
    }
    
    //MARK: Business Logic 
    
    mutating func adjustTemperatureWithType(_ type: TemperatureGroupSettingType, to temperature: Double) {
        
        switch type {
            
        case .slumber:
            
            model.low = temperature
            
        case .comfy:
            
            model.middle = temperature
            
        case .cosy:
            
            model.high = temperature
        }
        
    }
    
}
