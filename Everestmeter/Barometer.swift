import EverestmeterCore

typealias BarometerPressureHandler = (Pressure) -> Void
typealias BarometerErrorHandler = (String) -> Void

protocol Barometer: class {
    static var isPressureDataAvailable: Bool { get }

    var onDidMeasurePressure: BarometerPressureHandler? { get set }
    var onError: BarometerErrorHandler? { get set }

    init()

    func startMeasuring()
    func stopMeasuring()
}
