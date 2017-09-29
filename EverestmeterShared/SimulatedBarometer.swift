import Foundation
import EverestmeterCore

public final class SimulatedBarometer: Barometer {
    public var output: BarometerOutput
    public var onDidUpdateOutput: () -> Void = {}

    public init() {
        switch SimulatedBarometer.pressure {
        case .none:
            output = .none
        case .some(let value):
            let pressure = Pressure(kilopascals: value)
            output = .pressure(pressure)
        case .error(let error):
            output = .error(error)
        }
    }
}

public extension SimulatedBarometer {
    func startMeasuring() {
        onDidUpdateOutput()
    }

    func stopMeasuring() {}
}

private extension SimulatedBarometer {
    enum SimulatedPressure {
        case none
        case some(Double)
        case error(String)
    }

    static var pressure: SimulatedPressure {
        guard let candidate = ProcessInfo.processInfo.environment["SIMULATED_PRESSURE"] else {
            return .none
        }
        guard let value = Double(candidate) else {
            let error = NSLocalizedString("Invalid Simulated Pressure", comment: "")
            return .error(error)
        }
        return .some(value)
    }
}
