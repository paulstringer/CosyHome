import Foundation


struct TemperatureSettingEntity {
    
    private let MaxTemperature = 30.0
    private let MinTemperature = 7.0
    
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
            
            return max(MinTemperature, min(temperature, MaxTemperature))
            
        }
        
    }
    
    var maximum: Double {
        
        get {
            
            guard let next = next else {
                return MaxTemperature
            }
            
            return next - 1.0
        }
        
    }
    
    var minimum: Double {
        
        get {
            guard let previous = previous else {
                return MinTemperature
            }
            
            return previous + 1.0
        }
    }
    
    init(temperature: Double = 0.0, previous: Double? = nil, next: Double? = nil) {
        self.previous = previous
        self.next = next
        self._temperature = temperature
    }
    
    
    mutating func adjustTemperature(temperature: Double) {
        self._temperature = temperature
    }
    
    //MARK: Factory Method
    
    static func entitiesWithSlumber(slumber: Double, comfy: Double, cosy: Double ) -> (slumber: TemperatureSettingEntity, comfy: TemperatureSettingEntity, cosy: TemperatureSettingEntity) {
        
        let slumberSetting = TemperatureSettingEntity(temperature: slumber, next: comfy)
        let comfySetting = TemperatureSettingEntity(previous: slumber, temperature: comfy, next: cosy)
        let cosySetting = TemperatureSettingEntity(previous: comfy, temperature: cosy)
        
        return (slumberSetting, comfySetting, cosySetting)
        
        
    }
}
