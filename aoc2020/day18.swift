//
//  day18.swift
//  aoc2020
//
//  Created by 4 on 12/17/20.
//

import Foundation

func day18() {
    func fixString(_ s: String) -> String {
        var newA: [String] = []
        var i = 0
        if s.count == 5 { return s }
        while i < s.count {
            let c = s[i]
            if c == " " {
                
            } else if c == "(" {
                newA.append("("+fixString(sliceFrom(i, on: s))+")")
                i += 1 + sliceFrom(i, on: s).count
            } else if c == "+" {
                let prev = newA.popLast()!
                i += 2
                var next = String(s[i])
                if next == "(" {
                    next = "("+fixString(sliceFrom(i, on: s))+")"
                    i += 1 + sliceFrom(i, on: s).count
                }
                newA += ["(" + prev, "+", next+")"]
                
            } else {
                newA.append(String(c))
            }
            i += 1
        }
        return newA.joined()
    }
    
    func sliceFrom(_ i: Int, on s: String) -> String {
        var newS = ""
        var count = 1

        for c in s.dropFirst(i+1) {
            if c == ")" {
                count -= 1
                if count == 0 {
                    break
                }
            } else if c == "(" {
                count += 1
            }
            newS.append(c)
        }
        return newS
    }
    
    func getAns(for string: String) -> Int {
        var current = 0
        var mult = false
        var stack: [(Bool, Int)] = []
        for c in string {
            if c == " " {
                
            } else if c == "(" {
                stack.append((mult, current))
                mult = false
                current = 0
            } else if c.isNumber {
                if mult { current *= Int(String(c))! }
                else { current += Int(String(c))! }
            } else if c.isin("*+") {
                mult = c == "*"
            } else {
                let old = stack.popLast()!
                if old.0 { current *= old.1 }
                else { current += old.1 }
            }
        }
        return current
    }
    
    let list = sd(18)
    
    var a1 = 0
    var a2 = 0
    
    for line1 in list {
        let line2 = fixString(line1)
        
        a1 += getAns(for: line1)
        a2 += getAns(for: line2)
    }
    
    print("18:", a1, a2)
}
   
//    func evaluate(_ s: String) -> Int {
//        var current = 0
//        var add = true
//        var i = 0
//        while i < s.count {
//            let c = s[i]
//            if c == " " {
//
//            } else if c == "(" {
//                if add { current += evaluate(sliceFrom(i, on: s)) }
//                i += sliceFrom(i, on: s).count+1
//            } else if c.isNumber {
//                if add { current += Int(String(c))! }
//            } else if c.isin("*+") {
//                add = c == "+"
//            } else {
//                print("errors")
//            }
//            i += 1
//        }
//        var i = 0
//        while i < s.count {
//            let c = s[i]
//            if c == " " {
//
//            } else if c == "(" {
//                if add { current += evaluate(sliceFrom(i, on: s)) }
//                i += sliceFrom(i, on: s).count+1
//            } else if c.isNumber {
//                if add { current += Int(String(c))! }
//            } else if c.isin("*+") {
//                add = c == "+"
//            } else {
//                print("errors")
//            }
//            i += 1
//        }
//        return current
//    }
//



