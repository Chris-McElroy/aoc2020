//
//  day5.swift
//  aoc2020
//
//  Created by 4 on 12/22/20.
//

import Foundation

func day5() {
    let s = sd(5).map { $0.reduce(0) { x,y in x*2 + y.isin("RB").int } }
    print("5:", s.max()!,(s.min()!...s.max()!).filter({ !$0.isin(s) }).first!)
}
