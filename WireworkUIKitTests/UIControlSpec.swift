import Foundation
import Quick
import Nimble
import Wirework
import WireworkUIKit

class UIControlSpec: QuickSpec {
    override func spec() {
        describe("UIControl") {
            describe("wwControl") {
                it("wraps UIControl control events", andCleansUpResources: true) {
                    let control = UIControl()
                    let bag = SubscriptionBag()
                    var tapped = false
                    control.wwControlEvent(.TouchUpInside).subscribe { _ in
                        tapped = true
                    }.storeIn(bag)
                    control.sendActionsForControlEvents(.TouchUpInside)
                    expect(tapped).to(beTrue())
                }
            }
        }
    }
}
