import UIKit
import Quick
import Nimble
import Wirework
import WireworkUIKit

class UIProgressViewSpec: QuickSpec {
    override func spec() {
        describe("UIProgressView") {
            describe("wwProgress") {
                it("reflects title", andCleansUpResources: true) {
                    let bag = SubscriptionBag()
                    
                    let view = UIProgressView()
                    let variable = Variable(Float(0.2))
                    
                    variable.bindTo(view.wwProgress(animated: false)).storeIn(bag)
                    expect(view.progress).to(equal(0.2))
                    
                    variable.value = 0.8
                    expect(view.progress).to(equal(0.8))
                }
            }
        }
    }
}
