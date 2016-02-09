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
            
            describe("wwEnabled") {
                it("reflects enabled", andCleansUpResources: true) {
                    let bag = SubscriptionBag()
                    
                    let control = UIControl()
                    let variable = Variable(true)
                    
                    control.enabled = false
                    
                    variable.bindTo(control.wwEnabled).storeIn(bag)
                    expect(control.enabled).to(beTrue())
                    
                    variable.value = false
                    expect(control.enabled).to(beFalse())
                }
            }
            
            describe("wwSelected") {
                it("reflects selected", andCleansUpResources: true) {
                    let bag = SubscriptionBag()
                    
                    let control = UIControl()
                    let variable = Variable(true)
                    
                    control.selected = false
                    
                    variable.bindTo(control.wwSelected).storeIn(bag)
                    expect(control.selected).to(beTrue())
                    
                    variable.value = false
                    expect(control.selected).to(beFalse())
                }
            }
            
            describe("wwHighlighted") {
                it("reflects highlighted", andCleansUpResources: true) {
                    let bag = SubscriptionBag()
                    
                    let control = UIControl()
                    let variable = Variable(true)
                    
                    control.highlighted = false
                    
                    variable.bindTo(control.wwHighlighted).storeIn(bag)
                    expect(control.highlighted).to(beTrue())
                    
                    variable.value = false
                    expect(control.highlighted).to(beFalse())
                }
            }
        }
    }
}
