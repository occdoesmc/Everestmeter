import UIKit
import EverestmeterCore

final class AltitudeView: UIView {
    @IBOutlet fileprivate var dataView: AltitudeDataView!
    @IBOutlet fileprivate var errorView: ErrorView!
}

extension AltitudeView {
    func configure(with barometerOutput: BarometerOutput) {
        switch barometerOutput {
        case .none:
            showNothing()
        case .pressure(let pressure):
            let altitude = Altitude(pressure: pressure)
            showAltitude(altitude)
        case .error(let error):
            showError(error)
        }
    }
}

private extension AltitudeView {
    func showNothing() {
        dataView.hideAltitude()
        errorView.hideError()
    }

    func showAltitude(_ altitude: Altitude) {
        dataView.showAltitude(altitude)
        errorView.hideError()
    }

    func showError(_ error: String) {
        dataView.hideAltitude()
        errorView.showError(error)
    }
}
