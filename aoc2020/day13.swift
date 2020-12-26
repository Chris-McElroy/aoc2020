//
//  day13.swift
//  aoc2020
//
//  Created by 4 on 12/22/20.
//

import Foundation

func day13() {
    let list = sd(13)

    let t = Int(list[0])!

    var bus: [(Int, Int)] = list[1].split(separator: ",").enumerated().filter({ i,e in e != "x" }).map { i,e in (i, Int(e)!) }

    var fastest: Int = .max

    var a1 = 0
    
    for (_,b) in bus {
        if b - (t % b) < fastest {
            fastest = b - (t % b)
            a1 = fastest*b
        }
    }

    var i = 1

    var jump = bus.first!.1
    var base = 0
    var diff = 0
    bus = bus.sansFirst(1)
    var next = bus.popLast()!
    var a2 = 0

    while true {
        let t = (jump*i + base + next.0 - diff)
        if t % next.1 == 0 {
            jump *= next.1
            base = t
            diff = next.0
            i = 1
            if bus.count == 0 {
                a2 = t-next.0
                break
            }
            next = bus.popLast()!
        }
        i += 1
    }

    print("13:", a1, a2)
}
