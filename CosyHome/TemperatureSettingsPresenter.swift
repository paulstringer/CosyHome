import Foundation


class TemperatureSettingsPresenter: TemperatureSettingsInteractorOutput {
    
    var display: TemperatureSettingsDisplay
    
    init(display: TemperatureSettingsDisplay) {
        self.display = display
    }
    
    //MARK: Interactor Output
    
    var temperatures: [TemperatureSetting]? {
       
        didSet {
            
            if let temperatures = temperatures {
                
                for setting in temperatures {
                    
                    let item = itemForTemperature(setting)
                    
                    switch setting.type {
                    case .Slumber:
                        display.slumber = item
                    case .Comfy:
                        display.comfy = item
                    case .Cosy:
                        display.cosy = item
                    }
                
                }
                
            }

        }
    }
    
    var message: TemperatureSettingsInteractorOutputMessage?
    
    private func itemForTemperature(setting: TemperatureSetting) -> TemperatureSettingItem {
        
        let formatted = temperatureFormattedStringsForSetting(setting)
        
        return TemperatureSettingItem(temp: formatted.temp, minimum: formatted.min, maximum: formatted.max)
        
    }
    
    private func temperatureFormattedStringsForSetting(setting: TemperatureSetting) -> (temp: String, min: String, max:String) {
        
        let formatter = NSNumberFormatter()
        formatter.maximumFractionDigits = 1
        
        
        let temp = formatter.stringFromNumber(NSNumber(double: setting.temperature))!
        let min = formatter.stringFromNumber(NSNumber(double: setting.minimum))!
        let max = formatter.stringFromNumber(NSNumber(double: setting.maximum))!
        
        return (temp, min, max)
    }
}