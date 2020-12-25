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
    var i = 6
    
    while i != (2020-1) {
        let tmp = next
        next = i-list[next, default: i]
        list[tmp] = i
        i += 1
    }
    
    let ans1 = next
    
    while i != (30000000-1) {
        let tmp = next
        next = i-list[next, default: i]
        list[tmp] = i
        i += 1
    }
    
    print("15:", ans1, next)
}
