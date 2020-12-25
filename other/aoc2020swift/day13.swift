//
//  day13.swift
//  aoc2020
//
//  Created by 4 on 12/22/20.
//

import Foundation

func day13() {
    let list = sd(13)

//    var t = Int(list[0])!


    var bus: [(Int, Int)] = list[1].split(separator: ",").enumerated().filter({ i,e in e != "x" }).map { i,e in (i, Int(e)!) }

//    var fastest: Int = .max

//    var ans = 0
    //
    //for b in bus {
    //    if b - (t % b) < fastest {
    //        fastest = b - (t % b)
    //        ans = fastest*b
    //    }
    //    print(b, fastest)
    //}

    print(bus)

    var i = 1

    var jump = bus.first!.1
    var base = 0
    var diff = 0
    bus = bus.sansFirst(1)
    var next = bus.popLast()!

    while true {
        let t = (jump*i + base + next.0 - diff)
        if t % next.1 == 0 {
            jump *= next.1
            base = t
            diff = next.0
            i = 1
            if bus.count == 0 {
                print(t-next.0)
                break
            }
            next = bus.popLast()!
        }
        i += 1
    }


    //print(1008141%19)
    //print(ans, fastest)

}
