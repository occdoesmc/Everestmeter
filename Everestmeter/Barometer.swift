import CoreMotion
import EverestmeterCore

final class Barometer {
    let isPressureDataAvailable = CMAltimeter.isRelativeAltitudeAvailable()
    
    var onDidMeasurePressure: (Pressure) -> Void = { _ in }
    var onError: (String) -> Void = { _ in }
    
    private let altimeter = CMAltimeter()
    
    func startMeasuring() {
        let operationQueue = OperationQueue()
        altimeter.startRelativeAltitudeUpdates(to: operationQueue) { [weak self] altitudeData, error in
            OperationQueue.main.addOperation {
                self?.process(altitudeData)
                self?.process(error)
            }
        }
    }
    
    func stopMeasuring() {
        altimeter.stopRelativeAltitudeUpdates()
    }

    private func process(_ altitudeData: CMAltitudeData?) {
        guard let altitudeData = altitudeData else { return }
        let kilopascals = Double(altitudeData.pressure)
        let pressure = Pressure(kilopascals: kilopascals)
        onDidMeasurePressure(pressure)
    }
    
    private func process(_ error: Error?) {
        guard let error = error else { return }
        onError(error.localizedDescription)
    }
}
