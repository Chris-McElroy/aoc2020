//
//  day23.swift
//  aoc2020
//
//  Created by 4 on 12/22/20.
//

import Foundation

func day23() {
    let start = Date().timeIntervalSinceReferenceDate
    let l1 = [2,1,5,6,9,4,7,8,3]
    var list: [Int] = Array(repeating: 0, count: 1000001)
    
    for i in 0..<(l1.count-1) {
        list[l1[i]] = l1[i+1]
    }
    
    list[l1.last!] = 10
    for i in 10..<1000000 {
        list[i] = i+1
    }
    list[1000000] = 2
    
    var current = l1[0]
    var i = 0
    while i != 10000000 {
        let t1 = list[current]
        let t2 = list[t1]
        let t3 = list[t2]
        let next = list[t3]
        
        list[current] = next
        
        repeat {
            current -= 1
            if current < 1 { current = 1000000 }
        } while current.isin(t1,t2,t3)
        
        let newEnd = list[current]
        list[current] = t1
        list[t3] = newEnd
        
        current = next
        
        i += 1
        
//        print(list, current, travel)
    }
    
    print(list[1], list[list[1]])
    print("time: ", Date().timeIntervalSinceReferenceDate-start)
}// 9, 2, 7, 5, 4, 3 8, 6, 1
//92754386

// 4, 2, 1, 8, 6, 7, 5, 9, 3
// 86759342

// 46978532


// Optional(250343) Optional(651247) 250343*651247 163035127721
