//
//  day8.swift
//  aoc2020
//
//  Created by 4 on 12/22/20.
//

import Foundation

func day8() {
    var list = gd(8)
    
    for e in list.filter({ $0.opr != "acc" }) {
        list[e.num].opr.swap("nop","jmp")
        if run(list).end == list.count { break }
        list[e.num].opr.swap("nop","jmp")
    }

    print("8:", run(gd(8)).acc,run(list).acc)
}
