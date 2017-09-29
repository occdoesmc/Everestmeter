import UIKit
import EverestmeterCore
import EverestmeterShared

final class AltitudeViewController: UIViewController {
    @IBOutlet private var altitudeView: AltitudeView!
    private let barometer: Barometer = SimulatedBarometer.isAvailable ? SimulatedBarometer() : DeviceBarometer()
}

extension AltitudeViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        barometer.onDidUpdateOutput = { [altitudeView, barometer] in
            altitudeView?.configure(with: barometer.output)
        }
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        altitudeView.configure(with: barometer.output)
    }
}

extension AltitudeViewController {
    func startMeasuring() {
        barometer.startMeasuring()
    }

    func stopMeasuring() {
        barometer.stopMeasuring()
    }
}

extension AltitudeViewController {
    override var prefersStatusBarHidden: Bool {
        return true
    }
}

private extension SimulatedBarometer {
    static var isAvailable: Bool {
        if case .none = SimulatedBarometer().output { return false }
        return true
    }
}
