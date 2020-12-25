//
//  day24.swift
//  aoc2020
//
//  Created by 4 on 12/22/20.
//

import Foundation

func day24() {
    var list = sd(24)
    var flipd: [Int: Bool] = [:]
    var max = 10
    
    for line in list {
        var ur = 0
        var ea = 0
        var lastC: Character = "e"
        for c in line {
            switch c {
            case "n":
                ur += 1
                break
            case "s":
                ur -= 1
                break
            case "e":
                if lastC != "n" {
                    ea += 1
                }
                break
            case "w":
                if lastC != "s" {
                    ea -= 1
                }
                break
            default: break
            }
            lastC = c
        }
//        print(line, ur, ea)
        if (abs(ur) > max) { max = abs(ur) }
        if (abs(ea) > max) { max = abs(ea) }
        flipd[ur*1000+ea, default: false].toggle()
    }
    
    max += 2
    var newFlpd: [Int: Bool] = [:]
    
    let n = [(0,1),(0,-1),(1,-1),(-1,1),(1,0),(-1,0)]
    for _ in 0..<100 {
        for r in -max...max {
            for u in -max...max {
                let v = flipd[u*1000+r, default: false]
                var con = 0
                for nc in n {
                    con += flipd[(u+nc.0)*1000+(r+nc.1), default: false].int
                }
                if v {
                    newFlpd[u*1000+r] = con == 1 || con == 2
                } else {
                    newFlpd[u*1000+r] = con == 2
                }
            }
        }
        flipd = newFlpd
        newFlpd = [:]
        max += 1
        var co = 0
        for i in flipd {
            if i.value {
                co += 1
            }
        }
        
        print(co)
    }
    
    var co = 0
    for i in flipd {
        if i.value {
            co += 1
        }
    }
    
    print(co)
}

// guesses
// 28500
// 27923 wrong

