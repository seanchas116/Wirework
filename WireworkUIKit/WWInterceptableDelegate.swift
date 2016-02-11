import Foundation
import Wirework

class WWInterceptableDelegate: WWMethodInterceptor {
    private let _intercepted = Event<String>()
    private var _interceptedSelctors = Set<String>()
    
    func intercept(selector: String) -> Signal<Void> {
        return createSignal { emit in
            let bag = SubscriptionBag()
            self._intercepted.subscribe { s in
                if s == selector {
                    emit()
                }
            }.storeIn(bag)
            self._interceptedSelctors.insert(selector)
            Subscription { [weak self] in
                if let s = self {
                    s._interceptedSelctors.remove(selector)
                }
            }.storeIn(bag)
            return bag
        }
    }
    
    override func canInterceptSelector(selector: Selector) -> Bool {
        if _interceptedSelctors.contains(String(selector)) {
            return true
        }
        return false
    }
    
    override func didInterceptSelector(selector: Selector) {
        _intercepted.emit(String(selector))
    }
}
