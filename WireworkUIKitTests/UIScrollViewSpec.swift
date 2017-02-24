import UIKit
import Quick
import Nimble
import Wirework
import WireworkUIKit

private func createScrollView() -> UIScrollView {
    let scrollView = UIScrollView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
    let view = UIView(frame: CGRect(x: 0, y: 0, width: 200, height: 200))
    scrollView.addSubview(view)
    scrollView.contentSize = view.bounds.size
    return scrollView
}

private class ScrollViewTestDelegate: NSObject, UIScrollViewDelegate {
    var scrolled = false
    var zoomed = false
    
    @objc func scrollViewDidScroll(_ scrollView: UIScrollView) {
        scrolled = true
    }
    
    @objc func scrollViewDidZoom(_ scrollView: UIScrollView) {
        zoomed = true
    }
}

class UIScrollViewSpec: QuickSpec {
    override func spec() {
        describe("UIScrollView") {
            describe("wwContentOffset") {
                it("reflects content offset", andCleansUpResources: true) {
                    let scroll = createScrollView()
                    
                    let bag = SubscriptionBag()
                    let variable = Variable(CGPoint(x: 20, y: 10))
                    
                    variable.bindTo(scroll.wwContentOffset(animated: false)).addTo(bag)
                    expect(scroll.contentOffset).to(equal(CGPoint(x: 20, y: 10)))
                    
                    variable.value = CGPoint(x: 10, y: 20)
                    expect(scroll.contentOffset).to(equal(CGPoint(x: 10, y: 20)))
                }
            }
            describe("wwDidScroll") {
                it("intercepts scrolViewDidScroll", andCleansUpResources: true) {
                    let scroll = createScrollView()
                    
                    let bag = SubscriptionBag()
                    
                    var offset = CGPoint(x: 0, y: 0)
                    scroll.wwDidScroll.subscribe { offset = $0 }.addTo(bag)
                    scroll.contentOffset = CGPoint(x: 20, y: 10)
                    scroll.delegate?.scrollViewDidScroll?(scroll)
                    
                    expect(offset).to(equal(CGPoint(x: 20, y: 10)))
                }
            }
            describe("wwForwardToDelegate") {
                it("can forward method calls to normal delegate", andCleansUpResources: true) {
                    let scroll = createScrollView()
                    let delegate = ScrollViewTestDelegate()
                    scroll.wwForward(to: delegate)
                    
                    let bag = SubscriptionBag()
                    
                    var scrolled = false
                    
                    scroll.wwDidScroll.subscribe { _ in scrolled = true }.addTo(bag)
                    scroll.delegate?.scrollViewDidScroll?(scroll)
                    scroll.delegate?.scrollViewDidZoom?(scroll)
                    
                    expect(scrolled).to(beTrue())
                    expect(delegate.scrolled).to(beTrue())
                    expect(delegate.zoomed).to(beTrue())
                }
            }
        }
    }
}
