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

    var pos1 = (0,0)
    var pos2 = (0,0)
    var facing = (1,0)
    var way = (10,1)
    
    for (i,ins) in instr.enumerated() {
        switch ins.0 {
        case "F":
            pos1.0 += facing.0*ins.1
            pos1.1 += facing.1*ins.1
            while instr[i].1 != 0 {
                pos2.0 += way.0
                pos2.1 += way.1
                instr[i].1 -= 1
            }
            break
        case "R":
            while instr[i].1 != 0 {
                facing = (facing.1,-facing.0)
                way = (way.1,-way.0)
                instr[i].1 -= 90
            }
            break
        case "L":
            while instr[i].1 != 0 {
                facing = (-facing.1,facing.0)
                way = (-way.1,way.0)
                instr[i].1 -= 90
            }
            break
        case "N":
            pos1.1 += ins.1
            way.1 += ins.1
            break
        case "S":
            pos1.1 += -ins.1
            way.1 += -ins.1
            break
        case "E":
            pos1.0 += ins.1
            way.0 += ins.1
            break
        case "W":
            pos1.0 -= ins.1
            way.0 -= ins.1
            break
        default:
            break
        }
    }

    print("12:", abs(pos1.0)+abs(pos1.1), abs(pos2.0)+abs(pos2.1))

}
