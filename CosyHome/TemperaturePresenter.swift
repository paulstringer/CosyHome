import Foundation


class TemperaturePresenter: TemperatureInteractorOutput {
    
    var display: TemperatureGroupView
    
    init(display: TemperatureGroupView) {
        self.display = display
    }
    
    //MARK: Interactor Output
    
    var temperatures: [TemperatureGroupItemEntity]? {
       
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
    
    var message: TemperatureInteractorOutputMessage?
    
    private func itemForTemperature(setting: TemperatureGroupItemEntity) -> TemperatureGroupItem {
        
        let formatted = temperatureFormattedStringsForSetting(setting)
        
        return TemperatureGroupItem(temp: formatted.temp, minimum: formatted.min, maximum: formatted.max)
        
    }
    
    private func temperatureFormattedStringsForSetting(setting: TemperatureGroupItemEntity) -> (temp: String, min: String, max:String) {
        
        let formatter = NSNumberFormatter()
        formatter.maximumFractionDigits = 1
        
        
        let temp = formatter.stringFromNumber(NSNumber(double: setting.temperature))!
        let min = formatter.stringFromNumber(NSNumber(double: setting.minimum))!
        let max = formatter.stringFromNumber(NSNumber(double: setting.maximum))!
        
        return (temp, min, max)
    }
}