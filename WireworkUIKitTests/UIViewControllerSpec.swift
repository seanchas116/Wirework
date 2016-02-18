import UIKit
import Quick
import Nimble
import Wirework
import WireworkUIKit

class UIViewControllerSpec: QuickSpec {
    override func spec() {
        describe("UIViewController") {
            describe("wwTitle") {
                it("reflects title", andCleansUpResources: true) {
                    let bag = SubscriptionBag()
                    
                    let vc = UIViewController()
                    let variable = Variable("foobar")
                    
                    variable.bindTo(vc.wwTitle).addTo(bag)
                    expect(vc.title).to(equal("foobar"))
                    
                    variable.value = "poeee"
                    expect(vc.title).to(equal("poeee"))
                }
            }
        }
    }
}
