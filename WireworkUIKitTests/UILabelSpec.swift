import Foundation
import Quick
import Nimble
import Wirework
import WireworkUIKit

class UILabelSpec: QuickSpec {
    override func spec() {
        describe("UILabel") {
            describe("wwText") {
                it("reflect UILabel text", andCleansUpResources: true) {
                    let label = UILabel()
                    let variable = Variable("foo")
                    variable.bindTo(label.wwText)
                    expect(label.text).to(equal("foo"))
                    variable.value = "bar"
                    expect(label.text).to(equal("bar"))
                }
            }
        }
    }
}
