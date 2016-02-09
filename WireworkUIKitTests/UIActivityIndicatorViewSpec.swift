import UIKit
import Quick
import Nimble
import Wirework
import WireworkUIKit

class UIActivityIndicatorViewSpec: QuickSpec {
    override func spec() {
        describe("UIActivityIndicatorView") {
            describe("wwAnimating") {
                it("reflects animating bool", andCleansUpResources: true) {
                    let bag = SubscriptionBag()
                    
                    let indicator = UIActivityIndicatorView()
                    let variable = Variable(false)
                    
                    indicator.startAnimating()
                    variable.bindTo(indicator.wwAnimating).storeIn(bag)
                    expect(indicator.isAnimating()).to(beFalse())
                    
                    variable.value = true
                    expect(indicator.isAnimating()).to(beTrue())
                }
            }
        }
    }
}
