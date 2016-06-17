import Foundation

typealias TemperatureContextInput = (slumber: Double, comfy: Double, cosy: Double)

struct TemperatureContext: TemperatureGroupView {

    //MARK: Static Context Pesistence
    
    static var interactor: TemperatureInteractor?
    static var low: TemperatureGroupItem?
    static var middle: TemperatureGroupItem?
    static var high: TemperatureGroupItem?
    
    //MARK: Context Init
    
    init(temperatures: TemperatureContextInput) {
        
        TemperatureContext.interactor = createTemperatureInteractor(temperatures)
        
        TemperatureContext.interactor?.request(.load)
    }
    
    private func createTemperatureInteractor(temperatures: TemperatureContextInput) -> TemperatureInteractor {
    
        let group = TemperatureGroupModel(low: temperatures.slumber, middle: temperatures.comfy, high: temperatures.cosy)
        
        let gateway = TemperatureGatewaySimple(temperatures: group)
    
        let output = TemperaturePresenter(view: self)
    
        return TemperatureInteractor(gateway: gateway, output: output)
    
    }
    
    //MARK: Temperature Settings View
    
    var low: TemperatureGroupItem? {
        
        set {  TemperatureContext.low = newValue }
        
        get { return TemperatureContext.low }
        
    }
    
    var middle: TemperatureGroupItem? {
        
        set { TemperatureContext.middle = newValue }
        
        get { return TemperatureContext.middle }
        
    }
    
    var high: TemperatureGroupItem? {
        
        set { TemperatureContext.high = newValue }
        
        get { return TemperatureContext.high }
    }
    
    static func stateNameForItem(item: TemperatureGroupItem) -> String {
        
        if item == low {
            return FixtureTemperatureState.low.rawValue
        } else if item == middle {
            return FixtureTemperatureState.middle.rawValue
        } else if item == high {
            return FixtureTemperatureState.high.rawValue
        } else {
            return FixtureTemperatureState.undefined.rawValue
        }
    }
    
    
    
}