import UIKit
import EverestmeterCore

final class AltitudeDataView: UIView {
    @IBOutlet fileprivate var altitudeLabel: UILabel!
    @IBOutlet fileprivate var gaugeTopConstraint: NSLayoutConstraint!
    @IBOutlet fileprivate var gaugeHeightConstraint: NSLayoutConstraint!
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
