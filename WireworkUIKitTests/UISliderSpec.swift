import UIKit
import Quick
import Nimble
import Wirework
import WireworkUIKit

class UISliderSpec: QuickSpec {
    override func spec() {
        describe("UISlider") {
            describe("wwValue") {
                it("reflects value", andCleansUpResources: true) {
                    let slider = UISlider()
                    slider.minimumValue = 0
                    slider.maximumValue = 100
                    
                    let bag = SubscriptionBag()
                    let variable = Variable(Float(10))
                    
                    variable.bindTo(slider.wwValue).storeIn(bag)
                    expect(slider.value).to(equal(10))
                    
                    variable.value = 20
                    expect(slider.value).to(equal(20))
                }
            }
            
            describe("wwValueChanged") {
                it("emits value changes", andCleansUpResources: true) {
                    let slider = UISlider()
                    slider.minimumValue = 0
                    slider.maximumValue = 100
                    
                    let bag = SubscriptionBag()
                    var value = Float(0)
                    slider.wwValueChanged.subscribe { value = $0 }.storeIn(bag)
                    
                    slider.value = 20
                    slider.sendActionsForControlEvents(.ValueChanged)
                    
                    expect(value).to(equal(20))
                }
            }
        }
    }
}
