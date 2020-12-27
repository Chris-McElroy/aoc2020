//
//  day15.swift
//  aoc2020
//
//  Created by 4 on 12/15/20.
//

import Foundation

func day15() {
    var list: [Int: Int] = [2: 0,20: 1,0: 2,4: 3,1: 4,17: 5]
    var next = 0
    
    for i1 in stride(from: 6, to: 2020-1, by: 1) {
        let tmp = next
        next = i1-list[next, default: i1]
        list[tmp] = i1
    }
    
    let a1 = next
    
    for i2 in stride(from: 2020-1, to: 30000000-1, by: 1) {
        let tmp = next
        next = i2-list[next, default: i2]
        list[tmp] = i2
    }
    
    print("15:", a1, next)
}
