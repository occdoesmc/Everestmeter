import UIKit
import EverestmeterCore

final class AltitudeDataView: UIView {
    @IBOutlet private var altitudeLabel: UILabel!
    @IBOutlet private var gaugeTopConstraint: NSLayoutConstraint!
    @IBOutlet private var gaugeHeightConstraint: NSLayoutConstraint!
}

extension AltitudeDataView {
    func showAltitude(_ altitude: Altitude) {
        let altitudeDescription = AltitudeDescription(altitude: altitude)
        let altitudeGauge = AltitudeGauge(altitude: altitude, viewHeight: Double(bounds.height))
        isHidden = false
        altitudeLabel.text = altitudeDescription.text
        gaugeTopConstraint.constant = CGFloat(altitudeGauge.verticalOffset)
        gaugeHeightConstraint.constant = CGFloat(altitudeGauge.thickness)
    }

    func hideAltitude() {
        isHidden = true
        altitudeLabel.text = nil
        gaugeTopConstraint.constant = 0
        gaugeHeightConstraint.constant = 0
    }
}
