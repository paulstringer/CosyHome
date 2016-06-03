import Foundation

enum TemperatureSettingEntityType: String {
    case Slumber = "SLUMBER"
    case Comfy = "COMFY"
    case Cosy = "COSY"
}


struct TemperatureSettingEntity {
    
    let type: TemperatureSettingEntityType
    let temperature: Double
    let previous: Double?
    let next: Double?
    
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
    
    init(type: TemperatureSettingEntityType = .Slumber, temperature: Double = 0.0, previous: Double? = nil, next: Double? = nil) {
        self.type = type
        
        var temperature = temperature
        
        if let minimumTemperature = previous where temperature < minimumTemperature {
            temperature = minimumTemperature + 1
        }

        if let maximumTemperature = next where temperature > maximumTemperature {
            temperature = maximumTemperature - 1
        }

        self.temperature = max(7.0, min(temperature, 30.0))
        self.previous = previous
        self.next = next
    }
    
    
    static func entitiesWithTemperatureForSlumber(slumber: Double, comfy: Double, cosy: Double ) -> [TemperatureSettingEntity] {
        
        let temperatures = [slumber, comfy, cosy]
        
        let slumber = TemperatureSettingEntity(type: .Slumber, temperature: temperatures[0], next: temperatures[1])
        let comfy = TemperatureSettingEntity(type: .Comfy, previous: temperatures[0], temperature: temperatures[1], next: temperatures[2])
        let cosy = TemperatureSettingEntity(type: .Cosy, previous: temperatures[1], temperature: temperatures[2])
        
        return [slumber, comfy, cosy]
        
        
    }
    
}
