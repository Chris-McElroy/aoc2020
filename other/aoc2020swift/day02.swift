//
//  day2.swift
//  aoc2020
//
//  Created by 4 on 12/22/20.
//

import Foundation

func day2() {
    let list = sd(02).map { $0.split(separator: " ") }

    print(list.reduce((0,0)) { a,e in
        let b = e[0].split(separator: "-").map { Int($0)! }
        let c = e[1].first!
        return (a.0 + e[2].repeats(of: c).isin(b[0]...b[1]).int,
        a.1 + ((e[2][b[0]-1] == c) != (e[2][b[1]-1] == c)).int)
    })
}
