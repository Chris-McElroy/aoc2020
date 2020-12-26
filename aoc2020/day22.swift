//
//  day22.swift
//  aoc2020
//
//  Created by 4 on 12/21/20.
//

import Foundation

func day22() {
    
    func game1(de1: [Int], de2: [Int]) -> [Int] {
        var d1 = de1
        var d2 = de2
        
        while !d1.isEmpty && !d2.isEmpty {
            let c1 = d1.remove(at: 0)
            let c2 = d2.remove(at: 0)
            
            if c1 > c2 {
                d1.append(c1)
                d1.append(c2)
            } else {
                d2.append(c2)
                d2.append(c1)
            }
        }
        
        return d2.isEmpty ? d1 : d2
    }
    
    func game2(de1: [Int], de2: [Int]) -> (p1w: Bool, d: [Int]) {
        var d1 = de1
        var d2 = de2
        var seen: Set<[[Int]]> = []
        
        while !d1.isEmpty && !d2.isEmpty {
            if !seen.insert([d1, d2]).inserted { return (true, []) }
            
            let c1 = d1.remove(at: 0)
            let c2 = d2.remove(at: 0)
            var p1wins = c1 > c2
            
            if d1.count >= c1 && d2.count >= c2 {
                p1wins = game2(de1: d1.first(c1), de2: d2.first(c2)).p1w
            }
            
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
    
    var on1 = true
    for line in list.dropFirst() {
        if let i = Int(line) {
            if on1 { d1.append(i) }
            else { d2.append(i) }
        } else {
            on1 = false
        }
    }
    
    var w1 = game1(de1: d1, de2: d2)
    var w2 = game2(de1: d1, de2: d2).d
    
    var a1 = 0
    var a2 = 0
    var i = 1
    while !w1.isEmpty {
        a1 += w1.popLast()!*i
        a2 += w2.popLast()!*i
        i += 1
    }
    print("22:", a1, a2)
    
}
