import WatchKit
import EverestmeterWatchCore
import EverestmeterWatchShared

final class InterfaceController: WKInterfaceController {
    @IBOutlet private var altitudeLabel: WKInterfaceLabel!
    private let barometer = makeBarometer()
}

extension InterfaceController {
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        barometer.onDidUpdateOutput = { [barometer, altitudeLabel] in
            let text: String
            switch barometer.output {
            case .none:
                text = "Not Available"
            case .kilopascals(let kilopascals):
                let pressure = Pressure(kilopascals: kilopascals)
                let altitude = Altitude(pressure: pressure)
                let altitudeDescription = AltitudeDescription(altitude: altitude)
                text = altitudeDescription.text
            case .error(let error):
                text = error
            }
            altitudeLabel?.setText(text)
        }
    }

    override func willActivate() {
        super.willActivate()
        barometer.startMeasuring()
    }

    override func didDeactivate() {
        super.didDeactivate()
        barometer.stopMeasuring()
    }
}
