//
//  day4.swift
//  aoc2020
//
//  Created by 4 on 12/22/20.
//

import Foundation

func day4() {
    func isValid(_ field: String) -> Bool {
        let data = field.sansFirst(4)
        switch field.first(3) {
        case "byr": return (Int(data) ?? 0).isin(1920...2002)
        case "iyr": return (Int(data) ?? 0).isin(2010...2020)
        case "eyr": return (Int(data) ?? 0).isin(2020...2030)
        case "hgt": return (Int(data.dropLast(2)) ?? 0).isin(range[data.last(2)])
        case "hcl": return data.filter({!$0.isHexDigit}) == "#" && data.count == 7
        case "ecl": return data.isin(["amb","blu","brn","gry", "grn", "hzl", "oth"])
        case "pid": return Int(data) != nil && data.count == 9
        default: return false
        }
    }

    let passes = sd(4).split(separator: "").map { $0.joined(separator: " ") }
    let range = ["cm": 150...193, "in": 59...76]
    let reqFields = Set(["byr","iyr","eyr","hgt","hcl","ecl","pid"])
    var a1 = 0
    var a2 = 0
    
    for pass in passes {
        var rem1 = 7
        var rem2 = 7
        for part in pass.fullSplit(separator: " ") {
            rem1 -= part.first(3).isin(reqFields).int
            rem2 -= isValid(part).int
        }
        
        a1 += (rem1 == 0).int
        a2 += (rem2 == 0).int
    }
    
    print("4:", a1, a2)
}
