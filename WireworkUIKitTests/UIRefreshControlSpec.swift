import UIKit
import Quick
import Nimble
import Wirework
import WireworkUIKit

class UIRefreshControlSpec: QuickSpec {
    override func spec() {
        describe("UIRefreshControl") {
            describe("wwRefreshing") {
                it("reflects refreshing", andCleansUpResources: true) {
                    let bag = SubscriptionBag()
                    
                    let control = UIRefreshControl()
                    let variable = Variable(false)
                    
                    control.beginRefreshing()
                    variable.bindTo(control.wwRefreshing).storeIn(bag)
                    expect(control.refreshing).to(beFalse())
                    
                    variable.value = true
                    expect(control.refreshing).to(beTrue())
                }
            }
            describe("wwRefreshingChanged") {
                it("emit on refreshing changed", andCleansUpResources: true) {
                    let bag = SubscriptionBag()
                    
                    let control = UIRefreshControl()
                    var refreshing = false
                    
                    control.wwRefreshingChanged.subscribe { refreshing = $0 }.storeIn(bag)
                    
                    control.beginRefreshing()
                    control.sendActionsForControlEvents(.ValueChanged)
                    expect(refreshing).to(beTrue())
                }
            }
        }
    }
}
