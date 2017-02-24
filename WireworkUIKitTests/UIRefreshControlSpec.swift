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
                    variable.bindTo(control.wwRefreshing).addTo(bag)
                    expect(control.isRefreshing).to(beFalse())
                    
                    variable.value = true
                    expect(control.isRefreshing).to(beTrue())
                }
            }
            describe("wwRefreshingChanged") {
                it("emit on refreshing changed", andCleansUpResources: true) {
                    let bag = SubscriptionBag()
                    
                    let control = UIRefreshControl()
                    var refreshing = false
                    
                    control.wwRefreshingChanged.subscribe { refreshing = $0 }.addTo(bag)
                    
                    control.beginRefreshing()
                    control.sendActions(for: .valueChanged)
                    expect(refreshing).to(beTrue())
                }
            }
        }
    }
}
