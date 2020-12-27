//
//  day23.swift
//  aoc2020
//
//  Created by 4 on 12/22/20.
//

import Foundation

func day23() {
    let l = [2,1,5,6,9,4,7,8,3]
    
    var l1 = Array(repeating: 0, count: 10)
    for i in 0..<(l.count-1) {
        l1[l[i]] = l[i+1]
    }
    l1[l.last!] = l[0]
    
    var current = l[0]
    
    for _ in stride(from: 0, to: 100, by: 1) {
        let t1 = l1[current]
        let t2 = l1[t1]
        let t3 = l1[t2]
        let next = l1[t3]
        
        l1[current] = next
        
        repeat {
            current -= 1
            if current < 1 { current = 9 }
        } while current.isin(t1,t2,t3)
        
        let newEnd = l1[current]
        l1[current] = t1
        l1[t3] = newEnd
        
        current = next
    }
    
    var a1 = ""
    var j1 = l1[1]
    while j1 != 1 {
        a1.append(String(j1))
        j1 = l1[j1]
    }
    
    var l2: [Int] = Array(repeating: 0, count: 1000001)
    
    for i in 0..<(l.count-1) {
        l2[l[i]] = l[i+1]
    }
    
    l2[l.last!] = 10
    for i in 10..<1000000 {
        l2[i] = i+1
    }
    l2[1000000] = l[0]
    
    current = l[0]
    for _ in stride(from: 0, to: 10000000, by: 1) {
        let t1 = l2[current]
        let t2 = l2[t1]
        let t3 = l2[t2]
        let next = l2[t3]
        
        l2[current] = next
        
        repeat {
            current -= 1
            if current < 1 { current = 1000000 }
        } while current.isin(t1,t2,t3)
        
        let newEnd = l2[current]
        l2[current] = t1
        l2[t3] = newEnd
        
        current = next
    }
    
    print("23:", a1, l2[1]*l2[l2[1]])
}
