import UIKit
import EverestmeterCore

final class AltitudeViewController: UIViewController {
    @IBOutlet private var altitudeView: AltitudeView!

    private let barometer = preferredBarometerType.init()

    static var preferredBarometerType: Barometer.Type {
        return SimulatedBarometer.isPressureDataAvailable ? SimulatedBarometer.self : DeviceBarometer.self
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        showAltitude()
    }

    private func showAltitude() {
        checkPressureAvailability()
        observeErrors()
        observePressure()
        barometer.startMeasuring()
    }

    private func checkPressureAvailability() {
        guard !AltitudeViewController.preferredBarometerType.isPressureDataAvailable else { return }
        let error = NSLocalizedString("Barometer Not Available", comment: "")
        altitudeView.showError(error)
    }

    private func observeErrors() {
        barometer.onError = { [altitudeView] error in
            altitudeView?.showError(error)
        }
    }

    private func observePressure() {
        barometer.onDidMeasurePressure = { [altitudeView] pressure in
            let altitude = Altitude(pressure: pressure)
            altitudeView?.showAltitude(altitude)
        }
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
}
