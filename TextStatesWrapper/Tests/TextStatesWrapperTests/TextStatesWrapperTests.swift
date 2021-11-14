import XCTest
import SwiftUI
@testable import TextStatesWrapper

final class TextStatesWrapperTests: XCTestCase {
    @TextStatesWrapper(formatTo: .camelCase) var camelCasedText = "Let us test it"
    @TextStatesWrapper(formatTo: .kebabCase) var kebabCasedText = "Let us test it"
    @TextStatesWrapper(formatTo: .shakeCase) var snakeCasedText = "Let us test it"
    
    func testTransformation() throws {
        XCTAssertEqual(camelCasedText, "LetUsTestIt")
        XCTAssertEqual(kebabCasedText, "let-us-test-it")
        XCTAssertEqual(snakeCasedText, "let_us_test_it")
    }
}
