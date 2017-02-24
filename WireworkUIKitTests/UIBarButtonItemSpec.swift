import UIKit
import Quick
import Nimble
import Wirework
import WireworkUIKit

class UIBarButtonItemSpec: QuickSpec {
    override func spec() {
        describe("UIBarButtonItem") {
            describe("wwTapped") {
                it("emits when tapped", andCleansUpResources: true) {
                    let bag = SubscriptionBag()
                    let item = UIBarButtonItem()
                    var tapped = false
                    item.wwTapped.subscribe {
                        tapped = true
                    }.addTo(bag)
                    item.target?.perform(item.action)
                    expect(tapped).to(beTrue())
                }
            }
        }
    }
}
