import UIKit

final class ErrorView: UIView {
    @IBOutlet fileprivate var errorLabel: UILabel!
}

extension ErrorView {
    func showError(_ error: String) {
        isHidden = false
        errorLabel.text = error
    }
    
    func hideError() {
        isHidden = true
        errorLabel.text = nil
    }
}
