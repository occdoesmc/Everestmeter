public enum BarometerOutput {
    case none
    case kilopascals(Double)
    case error(String)
}

public protocol Barometer: class {
    var output: BarometerOutput { get }
    var onDidUpdateOutput: () -> Void { get set }

    init()

    func startMeasuring()
    func stopMeasuring()
}

public func makeBarometer() -> Barometer {
    return SimulatedBarometer.isAvailable ? SimulatedBarometer() : DeviceBarometer()
}
