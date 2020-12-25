//
//  day11.swift
//  aoc2020
//
//  Created by 4 on 12/22/20.
//

import Foundation

func day11() {
    var list = arrayData(11)

    var changes = 1
    let len1 = list.count
    let len2 = list[0].count
    let dir = [(0,-1),(0,1),(-1,0),(-1,1),(-1,-1),(1,0),(1,1),(1,-1)]
    var places: [[[(Int,Int)]]] = [[]]

    for i in 0..<len1 {
        for j in 0..<len2 {
            var p: [(Int,Int)] = []
            if list[i][j] != "." {
                for d in dir {
                    var a: Character = "."
                    var place: (Int,Int) = (i+d.0,j+d.1)
                    while a == "." && (0..<len1).contains(place.0) && (0..<len2).contains(place.1) {
                        a = list[place.0][place.1]
                        place = (place.0+d.0,place.1+d.1)
                    }
                    if a != "." {
                        p.append((place.0-d.0,place.1-d.1))
                    }
                }
            }
            places[i].append(p)
        }
        places.append([])
    }

    while changes > 0 {
        print("looping",changes)
        var newList: [[Character]] = list
        changes = 0
        for i in 0..<len1 {
            for j in 0..<len2 {
                let s = list[i][j]
                var full = 0
                if s != "." {
                    for p in places[i][j] {
                        full += (list[p.0][p.1] == "#").int
                    }
                    if s == "L" {
                        if full == 0 {
                            newList[i][j] = "#"
                            changes += 1
                        }
                    } else {
                        if full >= 5 {
                            newList[i][j] = "L"
                            changes += 1
                        }
                    }
                }
            }
        }
        list = newList
    }

    var seats = 0
    for l in list {
        for c in l {
            if c == "#" {
                seats += 1
            }
        }
    }

    print(seats)



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
