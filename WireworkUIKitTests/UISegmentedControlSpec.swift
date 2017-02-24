import UIKit
import Quick
import Nimble
import Wirework
import WireworkUIKit

class UISegmentedControlSpec: QuickSpec {
    override func spec() {
        describe("UISegmentedControl") {
            describe("wwSelectedSegmentIndex") {
                it("reflects selectedSegmentIndex", andCleansUpResources: true) {
                    let control = UISegmentedControl(items: ["a", "b", "c"])
                    
                    let bag = SubscriptionBag()
                    let variable = Variable(1)
                    
                    variable.bindTo(control.wwSelectedSegmentIndex).addTo(bag)
                    expect(control.selectedSegmentIndex).to(equal(1))
                    
                    variable.value = 2
                    expect(control.selectedSegmentIndex).to(equal(2))
                }
            }
            
            describe("wwSelectedSegmentChanged") {
                it("emits selectedSegmentIndex changes", andCleansUpResources: true) {
                    let control = UISegmentedControl(items: ["a", "b", "c"])
                    
                    let bag = SubscriptionBag()
                    var value = 0
                    control.wwSelectedSegmentIndexChanged.subscribe { value = $0 }.addTo(bag)
                    
                    control.selectedSegmentIndex = 2
                    control.sendActions(for: .valueChanged)
                    
                    expect(value).to(equal(2))
                }
            }
        }
    }
}
