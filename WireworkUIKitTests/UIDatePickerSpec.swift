import UIKit
import Quick
import Nimble
import Wirework
import WireworkUIKit

class UIDatePickerSpec: QuickSpec {
    override func spec() {
        describe("UIDatePicker") {
            describe("wwDate") {
                it("reflects date", andCleansUpResources: true) {
                    let picker = UIDatePicker()
                    let bag = SubscriptionBag()
                    let variable = Variable(NSDate())
                    let date = NSDate(timeIntervalSince1970: 10)
                    variable.bindTo(picker.wwDate(animated: false)).addTo(bag)
                    variable.value = date
                    expect(picker.date).to(equal(date))
                }
            }
            
            describe("wwDateChanged") {
                it("emits date changes by user", andCleansUpResources: true) {
                    let picker = UIDatePicker()
                    let bag = SubscriptionBag()
                    let variable = Variable(NSDate())
                    let date = NSDate(timeIntervalSince1970: 10)
                    picker.wwDateChanged.subscribe { variable.value = $0 }.addTo(bag)
                    picker.date = date
                    picker.sendActionsForControlEvents(.ValueChanged)
                    expect(variable.value).to(equal(date))
                }
            }
        }
    }
}
