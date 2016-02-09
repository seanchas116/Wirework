import UIKit
import Quick
import Nimble
import Wirework
import WireworkUIKit

class UINavigationItemSpec: QuickSpec {
    override func spec() {
        describe("UINavigationItem") {
            describe("wwTitle") {
                it("reflects title", andCleansUpResources: true) {
                    let bag = SubscriptionBag()
                    
                    let item = UINavigationItem()
                    let variable = Variable("foobar")
                    
                    variable.bindTo(item.wwTitle).storeIn(bag)
                    expect(item.title).to(equal("foobar"))
                    
                    variable.value = "poeee"
                    expect(item.title).to(equal("poeee"))
                }
            }
        }
    }
}
