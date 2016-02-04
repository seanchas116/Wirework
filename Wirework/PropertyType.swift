import Foundation

public protocol PropertyType {
    typealias Value
    var changed: Signal<Value> { get }
    var value: Value { get }
}

public protocol MutablePropertyType: class, PropertyType {
    var value: Value { get set }
}

extension PropertyType {
    public func map<T>(transform: (Value) -> T) -> Property<T> {
        return AdapterProperty(changed.map(transform)) { transform(self.value) }
    }
    
    public func bindTo<T: MutablePropertyType where T.Value == Value>(dest: T) -> Subscription {
        dest.value = value
        return changed.subscribe { newValue in
            dest.value = newValue
        }
    }
}

public func combine<P1: PropertyType, P2: PropertyType, V>(p1: P1, _ p2: P2, transform: (P1.Value, P2.Value) -> V) -> Property<V> {
    let changed = merge(
        p1.changed.map { _ in transform(p1.value, p2.value) },
        p2.changed.map { _ in transform(p1.value, p2.value) }
    )
    return AdapterProperty(changed) { transform(p1.value, p2.value) }
}

public func combine<P1: PropertyType, P2: PropertyType, P3: PropertyType, V>(p1: P1, _ p2: P2, _ p3: P3, transform: (P1.Value, P2.Value, P3.Value) -> V) -> Property<V> {
    let changed = merge(
        p1.changed.map { _ in transform(p1.value, p2.value, p3.value) },
        p2.changed.map { _ in transform(p1.value, p2.value, p3.value) },
        p3.changed.map { _ in transform(p1.value, p2.value, p3.value) }
    )
    return AdapterProperty(changed) { transform(p1.value, p2.value, p3.value) }
}
