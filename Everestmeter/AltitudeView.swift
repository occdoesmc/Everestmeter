import UIKit
import EverestmeterCore

final class AltitudeView: UIView {
    @IBOutlet fileprivate var dataView: AltitudeDataView!
    @IBOutlet fileprivate var errorView: ErrorView!
}

extension AltitudeView {
    func showAltitude(_ altitude: Altitude) {
        dataView.showAltitude(altitude)
        errorView.hideError()
    }
    
    func showError(_ error: String) {
        dataView.hideAltitude()
        errorView.showError(error)
    }
    
    func showDemo() {
        let pressure = AtmosphericPressure(kilopascals: 90)
        let altitude = Altitude(atmosphericPressure: pressure)
        dataView.showAltitude(altitude)
        errorView.hideError()
    }
}
