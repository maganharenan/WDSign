import XCTest
@testable import WDSign

final class WDSignTests: XCTestCase {
    let text = "{PRODUCT_LIST} lorem ipsum {USER_ID} lorem ipsum {USER_NAME}, {FORM_FIELD(000)} "
    
    func testBuildPlaceholdersList() {
        let stringComponents: Array<String> = text.components(separatedBy: " ").filter { $0.contains("{") && $0.contains("}") }
        
        XCTAssertEqual(stringComponents.count, 4)
    }
    
    func testReplacingPlaceholdersByValue() {
        
    }
}
