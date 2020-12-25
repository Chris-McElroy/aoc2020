//
//  day12.swift
//  aoc2020
//
//  Created by 4 on 12/22/20.
//

import Foundation

func day12() {
    let list = sd(12)

    var instr = list.map { ($0.first(1), Int($0.dropFirst(1))!) }

    var way = (10,1)
    var pos = (0,0)
//    var facing = (1,0)

    for (i,ins) in instr.enumerated() {
        switch ins.0 {
        case "F":
            while instr[i].1 != 0 {
                pos.0 += way.0
                pos.1 += way.1
                instr[i].1 -= 1
            }
            break
        case "R":
            while instr[i].1 != 0 {
                way = (way.1,-way.0)
                instr[i].1 -= 90
            }
            break
        case "L":
            while instr[i].1 != 0 {
                way = (-way.1,way.0)
                instr[i].1 -= 90
            }
            break
        case "N":
            way.1 += ins.1
            break
        case "S":
            way.1 += -ins.1
            break
        case "E":
            way.0 += ins.1
            break
        case "W":
            way.0 -= ins.1
            break
        default:
            break
        }
    }

    print(abs(pos.0)+abs(pos.1), pos)

}
