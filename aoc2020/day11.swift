//
//  day11.swift
//  aoc2020
//
//  Created by 4 on 12/22/20.
//

import Foundation

func day11() {
    let dict: [Character: Int] = ["#": 1, "L": 0, ".": 2]
    let list: [[Int]] = arrayData(11).map { $0.map { dict[$0]! } }

    var changes = 1
    let len1 = list.count
    let len2 = list[0].count
    let dir = [(0,-1),(0,1),(-1,0),(-1,1),(-1,-1),(1,0),(1,1),(1,-1)]
    var places1: [[[(Int,Int)]]] = [[]]
    var places2: [[[(Int,Int)]]] = [[]]

    for i in 0..<len1 {
        for j in 0..<len2 {
            var p1: [(Int,Int)] = []
            var p2: [(Int,Int)] = []
            if list[i][j] != 2 {
                for d in dir {
                    var a = 2
                    var place: (Int,Int) = (i+d.0,j+d.1)
                    while a == 2 && (0..<len1).contains(place.0) && (0..<len2).contains(place.1) {
                        a = list[place.0][place.1]
                        place = (place.0+d.0,place.1+d.1)
                    }
                    if (i+d.0).isin(0..<len1) && (j+d.1).isin(0..<len2) {
                        if list[i+d.0][j+d.1] != 2 {
                            p1.append((i+d.0, j+d.1))
                        }
                    }
                    if a != 2 {
                        p2.append((place.0-d.0,place.1-d.1))
                    }
                }
            }
            places1[i].append(p1)
            places2[i].append(p2)
        }
        places1.append([])
        places2.append([])
    }
    
    var list1 = list
    var list2 = list

    while changes > 0 {
        var newList1 = list1
        var newList2 = list2
        changes = 0
        for i in stride(from: 0, to: len1, by: 1) {
            for j in stride(from: 0, to: len2, by: 1) {
                let s1 = list1[i][j]
                let s2 = list2[i][j]
                var full1 = 0
                var full2 = 0
                if s1 != 2 {
                    for p in places1[i][j] {
                        full1 += list1[p.0][p.1]
                    }
                    for p in places2[i][j] {
                        full2 += list2[p.0][p.1]
                    }
                    if (s1 == 0 && full1 == 0) || (s1 == 1 && full1 >= 4) {
                        newList1[i][j] = list1[i][j]^1
                        changes += 1
                    }
                    if (s2 == 0 && full2 == 0) || (s2 == 1 && full2 >= 5) {
                        newList2[i][j] = list2[i][j]^1
                        changes += 1
                    }
                }
            }
        }
        list1 = newList1
        list2 = newList2
    }

    var seats1 = 0
    var seats2 = 0
    for i in stride(from: 0, to: len1, by: 1) {
        for j in stride(from: 0, to: len2, by: 1) {
            seats1 += (list1[i][j] == 1).int
            seats2 += (list2[i][j] == 1).int
        }
    }

    print("11:", seats1, seats2)



    //while changes > 0 {
    //    print("looping",changes)
    //    var newList: [[Character]] = list
    //    changes = 0
    //    for i in 0..<len1 {
    //        for j in 0..<len2 {
    //            let s = list[i][j]
    //            var adj: [Character] = []
    //            if j == 0 {
    //                if i == 0 {
    //                    adj += [list[i+1][j+1],list[i][j+1],list[i+1][j]]
    //                } else if i < len1-1 {
    //                    adj += [list[i+1][j+1],list[i][j+1],list[i-1][j],list[i+1][j],list[i-1][j+1]]
    //                } else {
    //                    adj += [list[i-1][j+1],list[i][j+1],list[i-1][j]]
    //                }
    //            } else if j < len2-1 {
    //                if i == 0 {
    //                    adj += [list[i+1][j+1],list[i][j+1],list[i+1][j],list[i][j-1],list[i+1][j-1]]
    //                } else if i < len1-1 {
    //                    adj += [list[i+1][j+1],list[i][j+1],list[i-1][j],list[i+1][j],list[i-1][j+1],list[i][j-1],list[i-1][j-1],list[i+1][j-1]]
    //                } else {
    //                    adj += [list[i-1][j+1],list[i][j+1],list[i-1][j],list[i][j-1],list[i-1][j-1]]
    //                }
    //            } else {
    //                if i == 0 {
    //                    adj += [list[i+1][j-1],list[i][j-1],list[i+1][j]]
    //                } else if i < len1-1 {
    //                    adj += [list[i+1][j-1],list[i][j-1],list[i-1][j],list[i+1][j],list[i-1][j-1]]
    //                } else {
    //                    adj += [list[i-1][j-1],list[i][j-1],list[i-1][j]]
    //                }
    //            }
    //            if s == "L" {
    //                if adj.repeats(of: "#") == 0 {
    //                    newList[i][j] = "#"
    //                    changes += 1
    //                }
    //            } else if s == "#" {
    //                if adj.repeats(of: "#") >= 4 {
    //                    newList[i][j] = "L"
    //                    changes += 1
    //                }
    //            }
    //        }
    //    }
    //    list = newList
    //}

}
