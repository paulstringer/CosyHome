import Foundation

//MARK: Entity Gateway Interfaces

protocol TemperatureGateway {
    func fetchGroup() -> TemperatureGatewayResponse
}

enum TemperatureGatewayResponse {
    case success(group: TemperatureGroupEntity)
    case error
}

//MARK: Interactor Interfaces

protocol TemperatureInteractorInput {
    mutating func request(request: TemperatureSettingsInputRequest)
}

protocol TemperatureInteractorOutput {
    var temperatureGroup: TemperatureGroupEntity? { get set }
    var message: TemperatureInteractorOutputMessage?{ get set }
}

enum TemperatureInteractorOutputMessage {
    case Error_Fetching_Temperatures
}

enum TemperatureSettingsInputRequest {
    case load
    case adjustLow(temperature: Double)
    case adjustMiddle(temperature: Double)
    case adjustHigh(temperature: Double)
}

//MARK: Interactor

struct TemperatureInteractor: TemperatureInteractorInput {
    
    let gateway: TemperatureGateway
    var output: TemperatureInteractorOutput
    var temperatureGroup: TemperatureGroupEntity?
    
    init(gateway: TemperatureGateway, output: TemperatureInteractorOutput) {
        self.gateway = gateway
        self.output = output
    }
    
    //MARK: Requests
    
    mutating func request(request: TemperatureSettingsInputRequest) {
        
        switch request {
        case .load:
            loadData()
        case .adjustLow(let temperature):
            adjustTemperatureWithType(.Slumber, to: temperature)
        case .adjustMiddle(let temperature):
            adjustTemperatureWithType(.Comfy, to: temperature)
        case .adjustHigh(let temperature):
            adjustTemperatureWithType(.Cosy, to: temperature)
        }
        
    }
    
    mutating private func loadData() {
        
        switch gateway.fetchGroup() {
            
        case .success(let group):
            
            temperatureGroup = group
            
            output.temperatureGroup = temperatureGroup
            
        case .error:
            
            output.message = .Error_Fetching_Temperatures
        }
        
    }
    
    private mutating func adjustTemperatureWithType(type: TemperatureGroupSettingType, to temperature: Double) {
    
        temperatureGroup?.adjustTemperatureWithType(type, to: temperature)
        
        guard let temperatureGroup = temperatureGroup else {
            return
        }
        
        output.temperatureGroup = temperatureGroup
        
    }
    
}
