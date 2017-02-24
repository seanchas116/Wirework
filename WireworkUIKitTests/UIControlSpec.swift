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
                    control.wwControlEvent(.touchUpInside).subscribe { _ in
                        tapped = true
                    }.addTo(bag)
                    control.sendActions(for: .touchUpInside)
                    expect(tapped).to(beTrue())
                }
            }
            
            describe("wwEnabled") {
                it("reflects enabled", andCleansUpResources: true) {
                    let bag = SubscriptionBag()
                    
                    let control = UIControl()
                    let variable = Variable(true)
                    
                    control.isEnabled = false
                    
                    variable.bindTo(control.wwEnabled).addTo(bag)
                    expect(control.isEnabled).to(beTrue())
                    
                    variable.value = false
                    expect(control.isEnabled).to(beFalse())
                }
            }
            
            describe("wwSelected") {
                it("reflects selected", andCleansUpResources: true) {
                    let bag = SubscriptionBag()
                    
                    let control = UIControl()
                    let variable = Variable(true)
                    
                    control.isSelected = false
                    
                    variable.bindTo(control.wwSelected).addTo(bag)
                    expect(control.isSelected).to(beTrue())
                    
                    variable.value = false
                    expect(control.isSelected).to(beFalse())
                }
            }
            
            describe("wwHighlighted") {
                it("reflects highlighted", andCleansUpResources: true) {
                    let bag = SubscriptionBag()
                    
                    let control = UIControl()
                    let variable = Variable(true)
                    
                    control.isHighlighted = false
                    
                    variable.bindTo(control.wwHighlighted).addTo(bag)
                    expect(control.isHighlighted).to(beTrue())
                    
                    variable.value = false
                    expect(control.isHighlighted).to(beFalse())
                }
            }
        }
    }
}
