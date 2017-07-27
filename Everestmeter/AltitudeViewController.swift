import UIKit
import EverestmeterCore

final class AltitudeViewController: UIViewController {
    @IBOutlet fileprivate var altitudeView: AltitudeView!
    fileprivate let barometer = preferredBarometerType.init()
}


extension AltitudeViewController {
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        showAltitude()
    }
}

private extension AltitudeViewController {
    func showAltitude() {
        checkPressureAvailability()
        observeErrors()
        observePressure()
        barometer.startMeasuring()
    }

    func checkPressureAvailability() {
        guard !AltitudeViewController.preferredBarometerType.isPressureDataAvailable else { return }
        let error = NSLocalizedString("Barometer Not Available", comment: "")
        altitudeView.showError(error)
    }

    func observeErrors() {
        barometer.onError = { [altitudeView] error in
            altitudeView?.showError(error)
        }
    }

    func observePressure() {
        barometer.onDidMeasurePressure = { [altitudeView] pressure in
            let altitude = Altitude(pressure: pressure)
            altitudeView?.showAltitude(altitude)
        }
    }
}

private extension AltitudeViewController {
    static var preferredBarometerType: Barometer.Type {
        return SimulatedBarometer.isPressureDataAvailable ? SimulatedBarometer.self : DeviceBarometer.self
    }
}

extension AltitudeViewController {
    override var prefersStatusBarHidden: Bool {
        return true
    }
}
