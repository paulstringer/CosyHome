import Foundation

enum TemperatureGroupItemEntityType: String {
    case Slumber = "SLUMBER"
    case Comfy = "COMFY"
    case Cosy = "COSY"
}

struct TemperatureGroupItemEntity {
    
    let type: TemperatureGroupItemEntityType
    
    var previous: Double?
    var next: Double?
    
    var _temperature: Double
    var temperature: Double {
        
        get {
        
            var temperature = _temperature
            
            if let minimumTemperature = previous where temperature <= minimumTemperature {
                temperature = minimumTemperature + 1
            }
            
            if let maximumTemperature = next where temperature >= maximumTemperature {
                temperature = maximumTemperature - 1
            }
            
            return max(7.0, min(temperature, 30.0))
            
        }
        
    }
    
    var maximum: Double {
        
        get {
            
            guard let next = next else {
                return 30.0
            }
            
            return next - 1.0
        }
        
    }
    
    var minimum: Double {
        
        get {
            guard let previous = previous else {
                return 7.0
            }
            
            return previous + 1.0
        }
    }
    
    init(type: TemperatureGroupItemEntityType = .Slumber, temperature: Double = 0.0, previous: Double? = nil, next: Double? = nil) {
        self.type = type
        self.previous = previous
        self.next = next
        self._temperature = temperature
    }
    
    
    mutating func adjustTemperature(temperature: Double) {
        self._temperature = temperature
    }
    
    //MARK: Factory Method
    
    static func entitiesForSlumber(slumber: Double, comfy: Double, cosy: Double ) -> (slumber: TemperatureGroupItemEntity, comfy: TemperatureGroupItemEntity, cosy: TemperatureGroupItemEntity) {
        
        let slumberSetting = TemperatureGroupItemEntity(type: .Slumber, temperature: slumber, next: comfy)
        let comfySetting = TemperatureGroupItemEntity(type: .Comfy, previous: slumber, temperature: comfy, next: cosy)
        let cosySetting = TemperatureGroupItemEntity(type: .Cosy, previous: comfy, temperature: cosy)
        
        return (slumberSetting, comfySetting, cosySetting)
        
        
    }
}
