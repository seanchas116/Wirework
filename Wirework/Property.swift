import Foundation

public class Property<T>: PropertyType {
    public typealias Value = T
    
    public var changed: Signal<Value> {
        fatalError("not implemented")
    }
    public var value: Value {
        fatalError("not implemented")
    }
}

public class Variable<T>: Property<T>, InPropertyType {
    
    private var _value: Value
    private let _changed = Event<Value>()
    private var _references = [AnyObject]()
    
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
    
    public func bind<T: PropertyType where T.Value == Value>(source: T) {
        let subscription = source.changed.subscribe { [weak self] value -> Void in
            self?.value = value
        }
        value = source.value
        _references.append(subscription)
        _references.append(source)
    }
    
    public init(_ value: Value) {
        _value = value
    }
}

class AdapterProperty<T>: Property<T> {
    private let _getValue: () -> T
    private let _changed: Signal<T>
    
    init(_ changed: Signal<T>, _ getValue: () -> T) {
        _getValue = getValue
        _changed = changed
    }
    
    override var changed: Signal<T> {
        return _changed
    }
    
    override var value: T {
        return _getValue()
    }
}
