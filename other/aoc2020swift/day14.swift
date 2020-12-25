//
//  day14.swift
//  aoc2020
//
//  Created by 4 on 12/15/20.
//

import Foundation

func day14() {
    let list = sd(14)
    var mask: String = ""
    var mem1: [Int: Int] = [:]
    var mem2: [Int: Int] = [:]

    for line in list {
        if line.hasPrefix("mask") {
            mask = line.sansFirst(7)
        } else {
            let s = line.split(separator: "=")
            let n = Int(s[0].dropFirst(4).dropLast(2))!
            
            // part 1
            var strK = String(Int(s[1].dropFirst(1))!, radix: 2)
            strK = String(Array(repeating: "0", count: 36-strK.count)) + strK
            var newK = ""
            for m in mask {
                newK.append(m == "X" ? strK.first! : m)
                strK = strK.sansFirst(1)
            }
            mem1[n, default: 0] = Int(newK, radix: 2)!
            
            // part 2
            var binN = String(n, radix: 2)
            binN = String(Array(repeating: "0", count: 36-binN.count)) + binN
            let k = Int(s[1].dropFirst(1))!
            var pos: [String] = [""]
            for m in mask {
                for i in 0..<pos.count {
                    if m == "X" { pos.append(pos[i] + "0") }
                    pos[i].append(m == "0" ? binN.first! : "1")
                }
                binN = binN.sansFirst(1)
            }
            for p in pos {
                mem2[Int(p, radix: 2)!, default: 0] = k
            }
        }
    }
    print(mem1.values.sum(), mem2.values.sum())
}
