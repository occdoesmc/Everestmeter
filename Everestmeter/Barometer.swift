import CoreMotion
import EverestmeterCore

final class Barometer {
    let isPressureDataAvailable = CMAltimeter.isRelativeAltitudeAvailable()

    var onDidMeasurePressure: (Pressure) -> Void = { _ in }
    var onError: (String) -> Void = { _ in }

    fileprivate let altimeter = CMAltimeter()
}

extension Barometer {
    func startMeasuring() {
        switch simulatedPressure {
        case .none:
            let operationQueue = OperationQueue()
            altimeter.startRelativeAltitudeUpdates(to: operationQueue) { [weak self] altitudeData, error in
                OperationQueue.main.addOperation {
                    self?.process(altitudeData)
                    self?.process(error)
                }
            }
        case .some(let value):
            let pressure = Pressure(kilopascals: value)
            onDidMeasurePressure(pressure)
        case .error(let error):
            onError(error)
        }
    }

    func stopMeasuring() {
        altimeter.stopRelativeAltitudeUpdates()
    }
}

private extension Barometer {
    func process(_ altitudeData: CMAltitudeData?) {
        guard let altitudeData = altitudeData else { return }
        let kilopascals = Double(altitudeData.pressure)
        let pressure = Pressure(kilopascals: kilopascals)
        onDidMeasurePressure(pressure)
    }

    func process(_ error: Error?) {
        guard let error = error else { return }
        onError(error.localizedDescription)
    }
}

private extension Barometer {
    enum SimulatedPressure {
        case none
        case some(Double)
        case error(String)
    }

    var simulatedPressure: SimulatedPressure {
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
