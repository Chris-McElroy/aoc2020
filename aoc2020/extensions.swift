//
//  extensions.swift
//  aoc2020
//
//  Created by 4 on 12/15/20.
//

import Foundation

public func run(_ instr: [Instr]) -> (end: Int, acc: Int, ops: Int) {
    var i: Int = 0
    var acc: Int = 0
    var visited: Set<Int> = []
    while i < instr.count && !i.isin(visited) {
        visited.insert(i)
        switch instr[i].opr {
        case "acc":
            acc += instr[i].arg
            i += 1
        case "jmp":
            i += instr[i].arg
        default:
            i += 1
        }
    }
    return (end: i, acc: acc, ops: visited.count)
}

public func runFast(_ instr: [Instr]) -> Int {
    var i: Int = 0
    var acc: Int = 0
    while i < instr.count {
        if instr[i].opr == "acc" {
            acc += instr[i].arg
        } else if instr[i].opr == "jmp" {
            i += instr[i].arg - 1
        }
        i += 1
    }
    return acc
}


public struct Instr {
    public var opr: String
    public var arg: Int
    public var num: Int
    
    init(_ s: String, _ i: Int) {
        opr = String(s.first(3))
        arg = Int(s.dropFirst(4))!
        num = i
    }
}

public extension Collection where Indices.Iterator.Element == Index {
    subscript(w i: Int?) -> Iterator.Element? {
        guard let j = i else { return nil }
        return self[index(startIndex, offsetBy: j % count)]
    }
    
    func first(_ k: Int) -> Self.SubSequence {
        return self.dropLast(count-k)
    }
    
    func last(_ k: Int) -> SubSequence {
        return self.dropFirst(count-k)
    }
    
    func slice(start: Int, len: Int) -> SubSequence {
        return self.first(start+len).dropFirst(start)
    }
    
    subscript(_ s: Int, _ e: Int) -> SubSequence {
        return self.first(e).dropFirst(s)
    }
    
    func each(_ k: Int) -> Array<SubSequence> {
        var array: Array<SubSequence> = []
        var i = 0
        while i < count {
            array.append(slice(start: i, len: Swift.min(k, count-i)))
            i += k
        }
        return array
    }
}

public extension Collection where Element: Equatable {
    func repeats(of e: Element) -> Int {
        return self.filter({ $0 == e }).count
    }
}

public extension Collection where Element: Hashable {
    func occurs(min: Int) -> Array<Element> {
        var counts: Dictionary<Element, Int> = [:]
        self.forEach { counts[$0, default: 0] += 1 }
        return Array(counts.filter { $0.value >= min }.keys)
    }
}

public extension Collection where Element: Numeric {
    func product() -> Element {
        return self.reduce(1) { x,y in x*y }
    }
    
    func sum() -> Element {
        return self.reduce(0) { x,y in x+y }
    }
}

public extension Collection where Element: AdditiveArithmetic {
    func twoSumTo(_ s: Element) -> [Element]? {
        guard let x = first(where: { contains(s-$0) }) else { return nil }
        return [x, s-x]
    }
    
    func nSumTo(_ s: Element, n: Int) -> [Element]? {
        if n == 2 { return twoSumTo(s) }
        for e in self {
            if var arr = nSumTo(s-e, n: n-1) {
                arr.append(e)
                return arr
            }
        }
        return nil
    }
}

public extension Array {
    subscript(w i: Int) -> Iterator.Element? {
        return self[index(startIndex, offsetBy: i % count)]
    }
    
    func first(_ k: Int) -> Self {
        return self.sansLast(count-k)
    }
    
    func last(_ k: Int) -> Self {
        return self.sansFirst(count-k)
    }
    
    func slice(start: Int, len: Int, by k: Int) -> Self {
        let newSlice = slice(start: start, len: len)
        return newSlice.enumerated().compactMap { i,e in i.isMultiple(of: k) ? e : nil }
    }
    
    func slice(start: Int, len: Int) -> Self {
        return self.first(start+len).sansFirst(start)
    }
    
    subscript(_ s: Int, _ e: Int) -> Self {
        return self.first(e).sansFirst(s)
    }
    
    func sansFirst(_ k: Int) -> Self {
        return Self(self.dropFirst(k))
    }
    
    func sansLast(_ k: Int) -> Self {
        return Self(self.dropLast(k))
    }
    
    mutating func pushOn(_ new: Element) {
        self = self.dropFirst() + [new]
    }
}

public extension Array where Element: Equatable {
    func fullSplit(separator: Element) -> Array<Self> {
        return self.split(whereSeparator: { $0 == separator}).map { Self($0) }
    }
}

public extension String {
    func fullSplit(separator: Character) -> Array<String> {
        let s = self.split(separator: separator, maxSplits: .max, omittingEmptySubsequences: false).map { String($0) }
        if s.last == "" {
            return s.sansLast(1)
        } else {
            return s
        }
    }
    
    func occurs(min: Int) -> String {
        var counts: Dictionary<Character, Int> = [:]
        self.forEach { counts[$0, default: 0] += 1 }
        return String(counts.filter { $0.value >= min }.keys)
    }
    
    subscript(w i: Int) -> Character? {
        return self[index(startIndex, offsetBy: i % count)]
    }
    
    func first(_ k: Int) -> Self {
        return self.sansLast(count-k)
    }
    
    func last(_ k: Int) -> Self {
        return self.sansFirst(count-k)
    }
    
    func slice(start: Int, before: Int, by k: Int) -> Self {
        let newSlice = slice(start: start, before: before)
        return String(newSlice.enumerated().compactMap { i,e in i.isMultiple(of: k) ? e : nil })
    }
    
    func slice(start: Int, before: Int) -> Self {
        return self.first(before).sansFirst(start)
    }
    
    func sansFirst(_ k: Int) -> Self {
        return Self(self.dropFirst(k))
    }
    
    func sansLast(_ k: Int) -> Self {
        return Self(self.dropLast(k))
    }
    
    func isin(_ string: String?) -> Bool {
        return string?.contains(self) == true
    }
}

public extension StringProtocol {
    subscript(offset: Int) -> Character {
        self[index(startIndex, offsetBy: offset)]
    }
    
    subscript(_ s: Int, _ e: Int) -> SubSequence {
        return self.first(e).dropFirst(s)
    }
}

public extension Comparable {
    func isin(_ collection: Array<Self>?) -> Bool {
        return collection?.contains(self) == true
    }
    
    mutating func swap(_ x: Self, _ y: Self) {
        self = (self == x) ? y : x
    }
}

public extension Equatable {
    func isin(_ one: Self, _ two: Self, _ three: Self) -> Bool {
        return self == one || self == two || self == three
    }
}

public extension Hashable {
    func isin(_ collection: Set<Self>?) -> Bool {
        return collection?.contains(self) == true
    }
}

public extension Character {
    func isin(_ string: String?) -> Bool {
        return string?.contains(self) == true
    }
}

public extension Numeric where Self: Comparable {
    func isin(_ range: ClosedRange<Self>?) -> Bool {
        return range?.contains(self) == true
    }
    
    func isin(_ range: Range<Self>?) -> Bool {
        return range?.contains(self) == true
    }
}

infix operator ** : MultiplicationPrecedence
public extension Numeric {
    func sqrd() -> Self {
        self*self
    }
    
    static func ** (lhs: Self, rhs: Int) -> Self {
        (0..<rhs).reduce(1) { x,y in x*lhs }
    }
}

public extension Bool {
    var int: Int { self ? 1 : 0 }
}

func timed(_ run: () -> Void) {
    let start = Date().timeIntervalSinceReferenceDate
    run()
    let end = Date().timeIntervalSinceReferenceDate
    print("in:", end-start)
}

public extension BinaryFloatingPoint {
    var isWhole: Bool { self.truncatingRemainder(dividingBy: 1) == 0 }
    var isEven: Bool { Int(self) % 2 == 0 }
    var isOdd: Bool { Int(self) % 2 == 1 }
    var int: Int? { isWhole ? Int(self) : nil }
}

public extension BinaryInteger {
    var isEven: Bool { self % 2 == 0 }
    var isOdd: Bool { self % 2 == 1 }
}

let currentDirectoryURL = URL(fileURLWithPath: "/Users/4/Library/Mobile Documents/com~apple~CloudDocs/files/code/aoc2020/aoc2020/input/")

public func id(_ num: Int) -> Array<Int> {
    do {
        let path = URL(fileURLWithPath: "input\(num)", relativeTo: currentDirectoryURL)
        let string = try String(contentsOf: path)
        let splitString = string.split(separator: "\n")
        return splitString.map { Int($0) ?? 0 }
    } catch {
        print("Error: bad file name")
        return []
    }
}

public func sd(_ num: Int) -> Array<String> {
    do {
        let path = URL(fileURLWithPath: "input\(num)", relativeTo: currentDirectoryURL)
        let string = try String(contentsOf: path)
        return string.fullSplit(separator: "\n")
    } catch {
        print("Error: bad file name")
        return []
    }
}

public func ssd(_ num: Int) -> [[String]] {
    do {
        let path = URL(fileURLWithPath: "input\(num)", relativeTo: currentDirectoryURL)
        let string = try String(contentsOf: path)
        return string.fullSplit(separator: "\n").map { $0.fullSplit(separator: " ") }
    } catch {
        print("Error: bad file name")
        return []
    }
}

public func gd(_ num: Int) -> [Instr] {
    do {
        let path = URL(fileURLWithPath: "input\(num)", relativeTo: currentDirectoryURL)
        let string = try String(contentsOf: path)
        return string.fullSplit(separator: "\n").enumerated().map { Instr($0.element, $0.offset) }
    } catch {
        print("Error: bad file name")
        return []
    }
}

public func arrayData(_ num: Int) -> Array<Array<Substring.Element>> {
    do {
        let path = URL(fileURLWithPath: "input\(num)", relativeTo: currentDirectoryURL)
        let string = try String(contentsOf: path)
        let splitString = string.split(separator: "\n")
        return splitString.map { Array($0) }
    } catch {
        print("Error: bad file name")
        return []
    }
}

