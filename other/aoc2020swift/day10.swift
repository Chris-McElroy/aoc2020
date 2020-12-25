//
//  day10.swift
//  aoc2020
//
//  Created by 4 on 12/22/20.
//

import Foundation

func day10() {
    let list = id(10).sorted()
    var gaps = [1,0,1,1]
    var vQueue = [0]
    var sQueue = [1,1,1]

    for e in list {
        gaps[e-vQueue.last!] += 1
        vQueue = vQueue.filter({ e-$0 <= 3 }) + [e]
        sQueue.pushOn(sQueue.last(vQueue.count-1).sum())
    }

    print(gaps.product(), sQueue.last!)
}
