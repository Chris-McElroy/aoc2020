//
//  day21.swift
//  aoc2020
//
//  Created by 4 on 12/20/20.
//

import Foundation

func day21() {
    let list = sd(21)
    var maybe: [String: Set<String>] = [:]
    var allIng: [String] = []
    var decided: [String: String] = [:]
 
    for line in list {
        let ing = line.split(separator: "(")[0].split(separator: " ").map { String($0) }
        let alg = line.split(separator: "(")[1].split(separator: " ").sansFirst(1).map { $0.dropLast() }
        for i in alg {
            if let current = maybe[String(i)] {
                let c3: Set<String> = Set(ing.map { String($0) })
                
//                print(current, ing, current.intersection(c3))
                maybe[String(i)] = current.intersection(c3)
            } else {
                maybe[String(i)] = Set(ing.map { String($0) })
            }
        }
        allIng.append(contentsOf: ing)
    }
    
    var c = 0
    
    for i in allIng {
        if !maybe.values.joined().contains(i) { c += 1 }
    }
    
    var oldCount = -1
    while decided.count < maybe.count {
        if decided.count == oldCount {
            print("fail")
            break
        } else { oldCount = decided.count}
        for m in maybe {
            if m.value.count == 1 {
                decided[m.key] = m.value.first!
                for m1 in maybe {
                    if m1.value.contains(m.value.first!) {
                        maybe[m1.key]!.remove(m.value.first!)
                    }
                }
            }
        }
    }
    
    var s = ""
    for v in decided.sorted(by: { x,y in x.key < y.key}) {
        s += v.value + ","
    }
    
    print(s)
    print(allIng.count, c)
}
