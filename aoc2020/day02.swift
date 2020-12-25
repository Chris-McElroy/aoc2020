//
//  day2.swift
//  aoc2020
//
//  Created by 4 on 12/22/20.
//

import Foundation

func day2() {
    let list = sd(2).map { $0.split(separator: " ") }
    var a1 = 0
    var a2 = 0
    
    for line in list {
        let bound = line[0].split(separator: "-").map { Int($0)! }
        let c = line[1].first!
        let pass = line[2]
        a1 += pass.repeats(of: c).isin(bound[0]...bound[1]).int
        a2 += ((pass[bound[0]-1] == c) != (pass[bound[1]-1] == c)).int
    }
    
    print("2:", a1, a2)
}
