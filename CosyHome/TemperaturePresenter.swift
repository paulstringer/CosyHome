import Foundation

class TemperaturePresenter: TemperatureInteractorOutput {
    
    var view: TemperatureGroupView
    
    init(view: TemperatureGroupView) {
        self.view = view
    }
    
    //MARK: Temperature Interactor Output
    
    var temperatureGroup: TemperatureGroupEntity? {
       
        didSet {
            
            if let temperatures = temperatureGroup?.settings {
                
                view.slumber = itemForTemperature(temperatures.slumber)
                
                view.comfy = itemForTemperature(temperatures.comfy)
                
                view.cosy = itemForTemperature(temperatures.cosy)

            }

        }
    }
    
    var message: TemperatureInteractorOutputMessage?
    
    //MARK: Private
    
    private func itemForTemperature(setting: TemperatureSettingEntity) -> TemperatureGroupItem {
        
        let formattedTemperature = formattedStrings(setting)
        
        return TemperatureGroupItem(temp: formattedTemperature, minimum: setting.minimum, maximum: setting.maximum)
        
    }
    
    private func formattedStrings(setting: TemperatureSettingEntity) -> String {
        let formatter = NSNumberFormatter()
        formatter.maximumFractionDigits = 1
        return formatter.stringFromNumber(NSNumber(double: setting.temperature))!
    }
}