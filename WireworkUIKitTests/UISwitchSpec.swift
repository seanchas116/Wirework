import UIKit
import Quick
import Nimble
import Wirework
import WireworkUIKit

class UISwitchSpec: QuickSpec {
    override func spec() {
        describe("UISwitch") {
            describe("wwOn") {
                it("reflects on", andCleansUpResources: true) {
                    let sw = UISwitch()
                    
                    let bag = SubscriptionBag()
                    let variable = Variable(true)
                    
                    sw.on = false
                    variable.bindTo(sw.wwOn(animated: false)).addTo(bag)
                    expect(sw.on).to(beTrue())
                    
                    variable.value = false
                    expect(sw.on).to(beFalse())
                }
            }
            
            describe("wwOnChanged") {
                it("emits on changes", andCleansUpResources: true) {
                    let sw = UISwitch()
                    
                    let bag = SubscriptionBag()
                    var value = false
                    sw.wwOnChanged.subscribe { value = $0 }.addTo(bag)
                    
                    sw.on = true
                    sw.sendActionsForControlEvents(.ValueChanged)
                    
                    expect(value).to(beTrue())
                }
            }
        }
    }
}
