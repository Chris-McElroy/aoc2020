//
//  day25.swift
//  aoc2020
//
//  Created by 4 on 12/22/20.
//

import Foundation

func day25() {
    let cardPK = 18356117
    let doorPK = 5909654
    let div = 20201227
    
    var loops = 0
    var val = 1
    while val != cardPK {
        loops += 1
        val *= 7
        val %= div
    }
    
    val = 1
    var l = 0
    while l != loops {
        val *= doorPK
        val %= div
        l += 1
    }
    
    print("25:", val, "see above")
}
