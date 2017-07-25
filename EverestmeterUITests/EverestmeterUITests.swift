import XCTest

final class EverestmeterUITests: XCTestCase {
    fileprivate let app = XCUIApplication()

    override func setUp() {
        super.setUp()
        continueAfterFailure = false
    }
}

extension EverestmeterUITests {
    func testAltitude() {
        app.launchEnvironment = ["SIMULATED_PRESSURE": "90"]
        app.launch()
        XCTAssertTrue(app.staticTexts["1014m"].isHittable)
    }

    func testOtherAltitude() {
        app.launchEnvironment = ["SIMULATED_PRESSURE": "100"]
        app.launch()
        XCTAssertTrue(app.staticTexts["112m"].isHittable)
    }
}
