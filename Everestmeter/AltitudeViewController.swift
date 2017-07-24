import UIKit
import EverestmeterCore

final class AltitudeViewController: UIViewController {
    @IBOutlet private var altitudeView: AltitudeView!
    private let barometer = Barometer()

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        UIApplication.isDemoModeEnabled ? showDemo() : showAltitude()
    }

    @IBAction private func userDidTapDismissButton() {
        dismiss(animated: true, completion: nil)
    }

    private func showDemo() {
        altitudeView.showDemo()
    }

    private func showAltitude() {
        checkPressureAvailability()
        observeErrors()
        observePressure()
        barometer.startMeasuring()
    }

    private func checkPressureAvailability() {
        guard !barometer.isPressureDataAvailable else { return }
        let error = NSLocalizedString("Barometer Not Available", comment: "Alert title")
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

private extension UIApplication {
    static var isDemoModeEnabled: Bool {
        return ProcessInfo.processInfo.arguments.contains("--demo-mode")
    }
}
