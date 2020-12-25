//
//  day16.swift
//  aoc2020
//
//  Created by 4 on 12/15/20.
//

import Foundation

func day16() {
    let list = sd(16)
    let tests = list.first(20).map { $0.split(separator: ":")[1].split(separator: " ") }
    var valid: [Set<Int>] = []
    for v in tests {
        let n = (v[0].split(separator: "-"), v[2].split(separator: "-"))
        valid.append(Set(Int(n.0[0])!...Int(n.0[1])!).union(Set(Int(n.1[0])!...Int(n.1[1])!)))
    }
    
    var sum = 0
    let tickets: [[Int]] = list.sansFirst(25).map( { $0.split(separator: ",").map { Int($0)! } })
    var working: [Set<Int>] = Array(repeating: Set(0..<20), count: 20)
    
    for t in tickets {
        for (j,n) in t.enumerated() {
            var fails: [Int] = []
            for (i,test) in valid.enumerated() {
                if !test.contains(n) {
                    fails.append(i)
                }
            }
            if fails.count == 20 { sum += n }
            else { fails.forEach { working[$0].remove(j) } }
        }
    }
    
    for (i,_) in working.enumerated().sorted(by: { x,y in x.element.count < y.element.count }) {
        for j in 0..<20 {
            if i != j {
                working[j].subtract(working[i])
            }
        }
    }
    
    let myT = [101,179,193,103,53,89,181,139,137,97,61,71,197,59,67,173,199,211,191,131]
    print("16:", sum, (0..<6).reduce(1) { p,n in p*myT[working[n].first!] })
}
