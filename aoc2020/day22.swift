//
//  day22.swift
//  aoc2020
//
//  Created by 4 on 12/21/20.
//

import Foundation

func day22() {
    
    // guess 32464 [14, 8, 48, 29, 39, 21, 19, 2, 50, 35, 17, 12, 27, 23, 1, 3, 47, 43, 38, 4, 42, 41, 25, 9, 46, 32, 33, 16, 36, 28, 26, 22, 18, 10, 49, 11, 40, 7, 44, 24, 6, 5, 45, 31, 34, 13, 37, 20, 30, 15]

//    let cwe = 0
    
    func game(de1: [Int], de2: [Int]) -> (p1w: Bool, d: [Int]) {
        var d1 = de1
        var d2 = de2
        var seen: Set<[[Int]]> = []
        
        while !d1.isEmpty && !d2.isEmpty {
            if !seen.insert([d1, d2]).inserted { return (true, []) }
            
            let c1 = d1.remove(at: 0)
            let c2 = d2.remove(at: 0)
            var p1wins = true
            
            if d1.count >= c1 && d2.count >= c2 {
                p1wins = game(de1: d1.first(c1), de2: d2.first(c2)).p1w
            } else {
                p1wins = c1 > c2
            }
            
//            if de1 == [9, 2, 6, 3, 1] {
//                cwe += 1
//                print(cwe, ": ", (!p1wins).int+1, c1, c2, d1, d2)
//            }
            if p1wins {
                d1.append(c1)
                d1.append(c2)
            } else {
                d2.append(c2)
                d2.append(c1)
            }
        }
        
        return (d2.isEmpty, d2.isEmpty ? d1 : d2)
    }
    
    let list = sd(22)
    var d1: [Int] = []
    var d2: [Int] = []
//
    var on1 = true
    for line in list.dropFirst() {
        if let i = Int(line) {
            if on1 { d1.append(i) }
            else { d2.append(i) }
        } else {
            on1 = false
        }
    }
//
    var d = game(de1: d1, de2: d2).d
    
//    var d = Array([d1,d2].joined())
    print(d)
    
    var c = 0
    var i = 1
    while !d.isEmpty {
        c += d.popLast()!*i
        i += 1
    }
    print(c)
    
}
