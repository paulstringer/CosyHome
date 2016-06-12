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

protocol TemperatureInteractorOutput {
    var temperatures: [TemperatureGroupItemEntity]? { get set }
    var message: TemperatureInteractorOutputMessage?{ get set }
}

enum TemperatureInteractorOutputMessage {
    case Error_Fetching_Temperatures
}

enum TemperatureSettingsInputRequest {
    case load
}

//MARK: Interactor

struct TemperatureInteractor {
    
    let gateway: TemperatureGateway
    var output: TemperatureInteractorOutput
    var temperatureGroup: TemperatureGroupEntity?
    
    init(gateway: TemperatureGateway, output: TemperatureInteractorOutput) {
        self.gateway = gateway
        self.output = output
    }
    
    //MARK: Requests
    
    mutating func request(request: TemperatureSettingsInputRequest) {
        
        switch gateway.fetchGroup() {
        
        case .success(let group):
            
            temperatureGroup = group
            
            output.temperatures = TemperatureInteractor.transform(group)
        
        case .error:
            
            output.message = .Error_Fetching_Temperatures
        }
        
    }
    
    //MARK: Adjustments
    
    mutating func adjustSlumber(temperature: Double) {
        
        adjustTemperatureWithType(.Slumber, to: temperature)
        
    }
    
    mutating func adjustCosy(temperature: Double) {
        
        adjustTemperatureWithType(.Cosy, to: temperature)
    }
    
    mutating func adjustComfy(temperature: Double) {
        
        adjustTemperatureWithType(.Comfy, to: temperature)
        
    }
    
    private mutating func adjustTemperatureWithType(type: TemperatureGroupItemEntityType, to temperature: Double) {
    
        temperatureGroup?.adjustTemperatureWithType(type, to: temperature)
        
        guard let temperatureGroup = temperatureGroup else {
            return
        }
        
        output.temperatures = TemperatureInteractor.transform(temperatureGroup)
        
    }
    
    private static func transform(group : TemperatureGroupEntity) -> [TemperatureGroupItemEntity] {

        let entities = [group.settings.slumber, group.settings.comfy, group.settings.cosy]
        
        return entities
        
    }
    
}
