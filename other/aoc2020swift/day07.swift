//
//  day7.swift
//  aoc2020
//
//  Created by 4 on 12/22/20.
//

import Foundation

func day7() {
    var d1: [String:Set<String>] = [:]
    var d2: [String:[(String, Int)]] = [:]
    var a1: [Set<String>] = [[],["shiny gold"],[]]
    var a2: [[String: Int]] = [[:],["shiny gold": 1]]

    sd(07).filter({ !"no".isin($0) }).forEach {
        var bags = $0.split(separator: " ").each(4)
        let mainName = String(bags.removeFirst().first(2).joined(separator: " "))
        d2[mainName] = bags.map { bag in
            let name = String(bag[1,3].joined(separator: " "))
            d1[name, default: []].insert(mainName)
            return (name, Int(bag.first!)!)
        }
    }

    while a1[1].count + a2[1].count != 0 {
        a1[1].forEach { a1[2].formUnion(d1[$0] ?? []) }
        a1 = [a1[0].union(a1[1]),a1[2],[]]
        
        for b in a2[1].keys {
            d2[b]?.forEach { a2[1][$0.0, default: 0] += $0.1*a2[1][b]! }
            a2[0][b, default: 0] += a2[1].removeValue(forKey: b)!
        }
    }

    print(a1[0].count-1, a2[0].values.sum()-1)
}
