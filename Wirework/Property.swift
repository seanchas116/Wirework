import Foundation

public class Property<T>: PropertyType {
    public typealias Value = T
    
    public var changed: Signal<Value> {
        fatalError("not implemented")
    }
  public   
    var value: Value {
        fatalError("not implemented")
    }
}

public class Variable<T>: Property<T> {
    
    private var _value: Value
    private let _changed = Event<Value>()
    private let _bag = SubscriptionBag()
    
    public override var changed: Signal<Value> {
        return _changed
    }
    
    public override var value: Value {
        get { return _value }
        set {
            _value = newValue
            _changed.emit(newValue)
        }
    }
    
    init(_ value: Value) {
        _value = value
    }
}

class MapProperty<T, U>: Property<U> {
    private let _source: Property<T>
    private let _transform: (T) -> U
    private let _changed: Signal<U>
    
    override var changed: Signal<U> {
        return _changed
    }
    
    override var value: U {
        return _transform(_source.value)
    }
    
    init(_ source: Property<T>, _ transform: (T) -> U) {
        _source = source
        _transform = transform
        _changed = source.changed.map { transform($0) }
    }
}

class CombineProperty<T, U>: Property<(T, U)> {
    private let _s1: Property<T>
    private let _s2: Property<U>
    private let _changed = Event<(T, U)>()
    
    override var changed: Signal<(T, U)> {
        return _changed
    }
    
    override var value: (T, U) {
        return (_s1.value, _s2.value)
    }
    
    init(_ s1: Property<T>, _ s2: Property<U>) {
        _s1 = s1
        _s2 = s2
        super.init()
        _s1.changed.subscribe { [weak self] _ in self?._notify() }
        _s2.changed.subscribe { [weak self] _ in self?._notify() }
    }
    
    private func _notify() {
        _changed.emit(value)
    }
}
