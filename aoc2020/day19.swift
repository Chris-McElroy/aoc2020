//
//  day19.swift
//  aoc2020
//
//  Created by 4 on 12/18/20.
//

import Foundation

func day19() {
    let list = sd(19)
    
    var rules: [Int: [[Int]]] = [:]
    var i = 0
    while list[i] != "" {
        let line = list[i]
        let n = Int(line.split(separator: ":").first!)!
        var j = 0
        let comp = line.split(separator: " ").sansFirst(1)
        rules[n] = [[]]
        var k = 0
        while j < comp.count {
            let c = comp[j]
            if let v = Int(c) {
                rules[n]![k].append(v)
            } else if c == "|" {
                rules[n]!.append([])
                k += 1
            } else if c == "\"a\"" {
                rules[n]![k].append(-1)
            } else if c == "\"b\"" {
                rules[n]![k].append(-2)
            } else {
                print("error")
            }
            j += 1
        }
        i += 1
    }
    var strs: [String] = []
    i += 1
    while i < list.count {
        strs.append(list[i])
        i += 1
    }
    
    var lens: [Int] = []
    
    for r in rules.sorted(by: { x,y in x.key < y.key }) {
        var l = 0
        var stack: [Int] = r.value[0]
        while !stack.isEmpty {
            let p = stack.popLast()!
            if p != -1 && p != -2 {
                stack.append(contentsOf: rules[p]![0])
            } else {
                l += 1
            }
        }
        lens.append(l)
    }
    
//    for i in 0..<rules.count {
//        print(rules[i]!, lens[i])
//    }
    
    func works(_ s: String, _ r: Int) -> Bool {
        if s.count != lens[r] { return false }
        
        for side in rules[r]! {
            var wrkn = true
            var k = 0
            for p in side {
                if p == -1 || p == -2 {
                    if s[k] != (p == -1 ? "a" : "b") {
                        wrkn = false
                        break
                    }
                    k += 1
                } else {
                    if !works(s.sansFirst(k).first(lens[p]), p) {
                        wrkn = false
                        break
                    }
                    k += lens[p]
                }
            }
            if wrkn {  return true }
        }
//        print("ffld:", s, r)
        return false
        
    }
    
    
    var con1 = 0
    var con2 = 0
    for s in strs {
//        print(rules, s, works(s, 0), lens)
        con1 += works(s, 0).int
        if s.count > 16 && s.count % 8 == 0 {
            if works(s.first(8), 42) && works(s.slice(start: 8, before: 16), 42) {
                var s2 = s.sansFirst(16)
                var m1 = 2
                var m2 = 0
                while works(s2.first(8), 42) {
                    m1 += 1
                    if s2.count > 8 {
                        s2 = s2.sansFirst(8)
                    } else {
                        break
                    }
                }
                if works(s2.first(8), 31) {
                    while works(s2.first(8), 31) {
                        m2 += 1
                        if s2.count > 8 {
                            s2 = s2.sansFirst(8)
                        } else {
                            con2 += (m1 > m2).int
                            break
                        }
                    }
                }
            }
        }
    }
    print("19:", con1, con2)
    
    
    
    
}
