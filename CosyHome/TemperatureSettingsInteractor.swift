import Foundation

protocol TemperatureSettingEntityGateway {
    func fetchAll() -> TemperatureSettingEntityGatewayResponse
}

enum TemperatureSettingEntityGatewayResponse {
    case success(entities: [TemperatureSettingEntity])
    case error
}

protocol TemperatureSettingsInteractorOutput {
    var temperatures: [TemperatureSetting]? { get set }
    var message: TemperatureSettingsInteractorOutputMessage?{ get set }
}

enum TemperatureSettingType {
    case Slumber
    case Comfy
    case Cosy
    
    init(type: TemperatureSettingEntityType) {
        switch type {
        case .Slumber:
            self = .Slumber
        case .Comfy:
            self = .Comfy
        case .Cosy:
            self = .Cosy
        }
    }
}

struct TemperatureSetting {
    let type: TemperatureSettingType
    let temperature: Double
    let minimum: Double
    let maximum: Double
    
    init(type: TemperatureSettingType = .Slumber, temperature: Double = 0.0, minimum: Double = 0.0, maximum: Double = 0.0) {
        self.type = type
        self.temperature = temperature
        self.minimum = minimum
        self.maximum = maximum
    }
}

func ==(lhs: TemperatureSetting, rhs: TemperatureSetting) -> Bool{
    return lhs.temperature == rhs.temperature
}

enum TemperatureSettingsInteractorOutputMessage {
    case Error_Fetching_Temperatures
}

struct TemperatureSettingsInteractor {
    
    let gateway: TemperatureSettingEntityGateway
    var output: TemperatureSettingsInteractorOutput
    
    init(gateway: TemperatureSettingEntityGateway, output: TemperatureSettingsInteractorOutput) {
        self.gateway = gateway
        self.output = output
    }
    
    mutating func start() {
        
        switch gateway.fetchAll() {
        
        case .success(let entities):
            
            output.temperatures = TemperatureSettingsInteractor.transform(entities)
            
        case .error:
            
            output.message = .Error_Fetching_Temperatures
        }
        
    }
    
    private static func transform(entities : [TemperatureSettingEntity]) -> [TemperatureSetting] {
        
        return entities.map({ (entity) -> TemperatureSetting in
            return TemperatureSetting(type:TemperatureSettingType(type: entity.type), temperature: entity.temperature, minimum: entity.minimum, maximum: entity.maximum)
        })
        
    }
    
}
