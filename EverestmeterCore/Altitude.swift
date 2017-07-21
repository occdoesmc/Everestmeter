public struct Altitude {
    public let meters: Double
}

extension Altitude {
    public init(pressure: Pressure) {
        let averageEarthTemperatureInKelvin = 289.15
        let pressureAtSeaLevel = Pressure(kilopascals: 101.325)
        let pressureRatio = pressureAtSeaLevel.kilopascals / pressure.kilopascals
        meters = ((pressureRatio.power(1 / 5.257) - 1) * averageEarthTemperatureInKelvin) / 0.0065
    }
}
