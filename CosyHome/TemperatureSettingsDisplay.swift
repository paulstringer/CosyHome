import Foundation

struct TemperatureSettingItem: Equatable {
    let temp: String
    let minimum: String
    let maximum: String
}

func ==(lhs: TemperatureSettingItem, rhs: TemperatureSettingItem ) -> Bool {
    
    return lhs.temp == rhs.temp
    
}

protocol TemperatureSettingsDisplay {
    
    var slumber: TemperatureSettingItem? { get set }
    var comfy: TemperatureSettingItem? { get set }
    var cosy: TemperatureSettingItem? { get set }
    
//    func setTemperatureSettings(settings:[TemperatureSettingItem])
    
}