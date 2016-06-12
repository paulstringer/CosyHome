import Foundation

typealias TemperatureContextInput = (slumber: Double, comfy: Double, cosy: Double)

struct TemperatureContext: TemperatureSettingsDisplay {

    //MARK: Static Context Pesistence
    
    static var interactor: TemperatureInteractor?
    static var slumber: TemperatureSettingItem?
    static var comfy: TemperatureSettingItem?
    static var cosy: TemperatureSettingItem?
    
    //MARK: Context Init
    
    init(temperatures: TemperatureContextInput) {
        
        TemperatureContext.interactor = createTemperatureInteractor(temperatures)
        
        TemperatureContext.interactor?.request(.load)
    }
    
    private func createTemperatureInteractor(temperatures: TemperatureContextInput) -> TemperatureInteractor {
    
        let gateway = TemperatureGatewaySimple(slumber: temperatures.slumber, comfy: temperatures.comfy, cosy: temperatures.cosy)
    
        let output = TemperaturePresenter(display: self)
    
        return TemperatureInteractor(gateway: gateway, output: output)
    
    }
    
    //MARK: Temperature Settings Display
    
    var slumber: TemperatureSettingItem? {
        
        set {  TemperatureContext.slumber = newValue }
        
        get { return TemperatureContext.slumber }
        
    }
    
    var comfy: TemperatureSettingItem? {
        
        set { TemperatureContext.comfy = newValue }
        
        get { return TemperatureContext.comfy }
        
    }
    
    var cosy: TemperatureSettingItem? {
        
        set { TemperatureContext.cosy = newValue }
        
        get { return TemperatureContext.cosy }
    }
    
    static func stateNameForItem(item: TemperatureSettingItem) -> String {
        
        if item == slumber {
            return FixtureTemperatureState.slumber.rawValue
        } else if item == comfy {
            return FixtureTemperatureState.comfy.rawValue
        } else if item == cosy {
            return FixtureTemperatureState.cosy.rawValue
        } else {
            return FixtureTemperatureState.undefined.rawValue
        }
    }
    
    
    
}