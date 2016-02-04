//
//  ObservableArraySpec.swift
//  Wirework
//
//  Created by Ryohei Ikegami on 2016/02/03.
//
//

import Foundation
import Quick
import Nimble
import Wirework

class ChangesRecorder {
    private let bag = SubscriptionBag()
    var removals = [Range<Int>]()
    var insertions = [Range<Int>]()
    var moves = [(Range<Int>, Int)]()
    var itemChanges = [Int]()
    
    init<T>(_ array: ObservableArray<T>) {
        array.updated.subscribe { [unowned self] in
            switch $0 {
            case .Removed(let range):
                self.removals.append(range)
            case .Inserted(let range):
                self.insertions.append(range)
            case .Moved(let range, let at):
                self.moves.append((range, at))
            case .ItemChanged(let at):
                self.itemChanges.append(at)
            }
        }.storeIn(bag)
    }
}

class ObservableArraySpec: QuickSpec {
    override func spec() {
        describe("ObservableArray") {
            describe("replaceRange") {
                it("replaces values and emits changes") {
                    let array = ObservableArray<Int>([1, 2, 3, 4, 5])
                    let recorder = ChangesRecorder(array)
                    
                    array.replaceRange(1 ... 3, with: [10, 20, 30, 40, 50])
                    expect(array.value).to(equal([1, 10, 20, 30, 40, 50, 5]))
                    expect(recorder.removals).to(equal([1 ... 3]))
                    expect(recorder.insertions).to(equal([1 ... 5]))
                }
            }
            describe("moveRange") {
                it("moves values and emits changes") {
                    let array = ObservableArray<Int>([1, 2, 3, 4, 5])
                    let recorder = ChangesRecorder(array)
                    
                    array.moveRange(1 ... 3, to: 5)
                    expect(array.value).to(equal([1, 5, 2, 3, 4]))
                    expect(recorder.moves[0].0).to(equal(1 ... 3))
                    expect(recorder.moves[0].1).to(equal(5))
                }
            }
            describe("append") {
                it("appends a value and emit changes") {
                    let array = ObservableArray<Int>([1, 2, 3, 4, 5])
                    let recorder = ChangesRecorder(array)
                    
                    array.append(10)
                    
                    expect(array.value).to(equal([1, 2, 3, 4, 5, 10]))
                    expect(recorder.removals).to(equal([]))
                    expect(recorder.insertions).to(equal([5 ... 5]))
                }
            }
            describe("removeAll") {
                it("removes all values and emit changes") {
                    let array = ObservableArray<Int>([1, 2, 3, 4, 5])
                    let recorder = ChangesRecorder(array)
                    
                    array.removeAll()
                    
                    expect(array.value).to(equal([]))
                    expect(recorder.removals).to(equal([0 ... 4]))
                    expect(recorder.insertions).to(equal([]))
                }
            }
            describe("subscript assignment") {
                it("emits item change") {
                    let array = ObservableArray<Int>([1, 2, 3, 4, 5])
                    let recorder = ChangesRecorder(array)
                    
                    array[2] = 10
                    array[3] = 20
                    
                    expect(array.value).to(equal([1, 2, 10, 20, 5]))
                    expect(recorder.itemChanges).to(equal([2, 3]))
                }
            }
            it("can bind to variable") {
                let bag = SubscriptionBag()
                let array = ObservableArray<Int>([1, 2, 3, 4, 5])
                let bound = Variable([Int]())
                array.bindTo(bound).storeIn(bag)
                array.replaceRange(1 ... 3, with: [10, 20, 30, 40, 50])
                expect(bound.value).to(equal([1, 10, 20, 30, 40, 50, 5]))
                array.value = [1, 2, 3]
                expect(bound.value).to(equal([1, 2, 3]))
            }
        }
    }
}
