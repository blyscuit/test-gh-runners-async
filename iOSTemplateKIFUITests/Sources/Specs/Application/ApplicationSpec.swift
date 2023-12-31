//
//  ApplicationSpec.swift
//

import Foundation
import Nimble
import Quick

final class ApplicationSpec: QuickSpec {

    override func spec() {

        describe("a iOSTemplate screen") {

            beforeEach {
                // Navigate to the testing screen
            }

            afterEach {
                // Navigate to neutral state
            }

            context("when opens") {

                it("shows its UI components") {
                    self.tester().waitForView(withAccessibilityLabel: "Hello")
                }
            }
        }
    }
}
