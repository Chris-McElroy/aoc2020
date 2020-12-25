//
//  day3.swift
//  aoc2020
//
//  Created by 4 on 12/22/20.
//

import Foundation

func day3() {
    let w = [1,3,5,7,0.5].map { d in
        sd(3).enumerated().reduce(0) { t,l in
            t + (l.element[w: (d*Double(l.offset)).int] == "#").int
        }
    }

    print("3:", w[1], w.product())
}
