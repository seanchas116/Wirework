//
//  ObservableCollection.swift
//  Wirework
//
//  Created by Ryohei Ikegami on 2016/02/03.
//
//

import Foundation

public enum CollectionUpdate {
    case Inserted(Range<Int>)
    case Removed(Range<Int>)
    case Moved(Range<Int>, Int)
    case ItemChanged(Int)
}

public protocol ObservableCollectionType: CollectionType, PropertyType {
    var updated: Signal<CollectionUpdate> { get }
}

public protocol MutableObservableCollectionType: ObservableCollectionType, MutableCollectionType, MutablePropertyType {
}

public class ObservableArray<T>: MutableObservableCollectionType {
    public typealias Value = Array<Element>
    public typealias Element = T
    public typealias Generator = Array<Element>.Generator
    public typealias Index = Array<Element>.Index
    
    private var _data: [Element]
    private let _updated = Event<CollectionUpdate>()
    
    public init<C: CollectionType where C.Generator.Element == Element>(_ xs: C) {
        _data = Array(xs)
    }
    
    public convenience init() {
        self.init([])
    }
    
    public var updated: Signal<CollectionUpdate> {
        return _updated
    }
    
    public var changed: Signal<[Element]> {
        return updated.map { _ in self._data }
    }
    
    public var value: [Element] {
        get {
            return _data
        }
        set {
            replaceRange(startIndex ..< endIndex, with: newValue)
        }
    }
    
    public func generate() -> Generator {
        return _data.generate()
    }
    
    public var count: Int {
        return _data.count
    }
    
    public let startIndex = 0
    
    public var endIndex: Int {
        return _data.count
    }
    
    public func replaceRange<C: CollectionType where C.Generator.Element == Element>(removedRange: Range<Int>, with xs: C) {
        let start = removedRange.startIndex
        let insertedRange = start ..< start + Int(xs.count.toIntMax())
        if removedRange.count > 0 {
            _data.replaceRange(removedRange, with: [])
            _updated.emit(.Removed(removedRange))
        }
        if insertedRange.count > 0 {
            _data.replaceRange(start ..< start, with: xs)
            _updated.emit(.Inserted(insertedRange))
        }
    }
    
    public func moveRange(subRange: Range<Int>, to i: Int) {
        let sub = _data[subRange]
        _data.replaceRange(subRange, with: [])
        _data.insertContentsOf(sub, at: i - subRange.count)
        _updated.emit(.Moved(subRange, i))
    }
    
    public subscript (i: Int) -> Element {
        get {
            return _data[i]
        }
        set {
            _data[i] = newValue
            _updated.emit(.ItemChanged(i))
        }
    }
    
    public subscript (range: Range<Int>) -> ArraySlice<Element> {
        get {
            return _data[range]
        }
        set {
            replaceRange(range, with: newValue)
        }
    }
}

extension ObservableArray {
    public func append(x: Element) {
        insert(x, atIndex: count)
    }
    
    public func appendContentsOf<C: CollectionType where C.Generator.Element == Element>(xs: C) {
        insertContentsOf(xs, at: count)
    }
    
    public func insert(x: Element, atIndex i: Int) {
        insertContentsOf([x], at: i)
    }
    
    public func insertContentsOf<C: CollectionType where C.Generator.Element == Element>(xs: C, at i: Int) {
        replaceRange(i ..< i, with: xs)
    }
    
    public func removeAtIndex(i: Int) {
        replaceRange(i ... i, with: [])
    }
    
    public func removeFirst() {
        removeAtIndex(0)
    }
    
    public func removeLast() {
        removeAtIndex(count)
    }
    
    public func removeAll() {
        replaceRange(0 ..< count, with: [])
    }
}
