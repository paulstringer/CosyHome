import Foundation

@testable import CosyHome

class TemperatureGroupViewSpy: TemperatureGroupView {
    var low: TemperatureGroupItem?
    var middle: TemperatureGroupItem?
    var high: TemperatureGroupItem?
}