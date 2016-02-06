import Foundation

public class Property<T>: PropertyType {
    #if MONITOR_RESOURCES
    private let _resourceMonitor = ResourceMonitor("Property")
    #endif
    
    public typealias Value = T
    
    public var changed: Signal<T> {
        fatalError("not implemented")
    }
    public var value: Value {
        fatalError("not implemented")
    }
}

public class Variable<T>: Property<T>, MutablePropertyType {
    private var _value: Value
    private let _changed = Event<T>()
    
    public override var changed: Signal<T> {
        return _changed
    }
    
    public override var value: Value {
        get { return _value }
        set {
            _value = newValue
            _changed.emit(newValue)
        }
    }

    public init(_ value: Value) {
        _value = value
    }
}

public func createProperty<T>(changedSignal: Signal<T>, getValue: () -> T) -> Property<T> {
    return AdapterProperty(changedSignal, getValue)
}

private class AdapterProperty<T>: Property<T> {
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
