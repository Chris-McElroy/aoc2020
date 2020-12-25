//
//  day6.swift
//  aoc2020
//
//  Created by 4 on 12/22/20.
//

import Foundation

func day6() {
    let list = sd(6).split(separator: "")
    let groups = list.map { ($0.joined(separator: ""),$0.count) }
    let a1 = groups.map({ $0.0.occurs(min: 1).count }).sum()
    let a2 = groups.map({ $0.0.occurs(min: $0.1).count }).sum()
    
    print("6:", a1, a2)
}
