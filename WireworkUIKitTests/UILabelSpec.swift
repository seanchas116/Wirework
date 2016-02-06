import Foundation
import Quick
import Nimble
import WireworkUIKit

class UILabelSpec: QuickSpec {
    override func spec() {
        describe("UILabel") {
            describe("wwText") {
                it("reflect UILabel text") {
                    let label = UILabel()
                    let prop = label.wwText
                    prop.value = "hogehoge"
                    expect(label.text).to(equal("hogehoge"))
                }
            }
        }
    }
}
