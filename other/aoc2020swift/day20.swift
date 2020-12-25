//
//  day20.swift
//  aoc2020
//
//  Created by 4 on 12/19/20.
//

import Foundation

func day20() {
    
    let list = sd(20)
    
    var tiles: [Int: [String]] = [:]
    var bords: [Int: [String]] = [:]
    var current = 0
    
    for i in list {
        if i != "" {
            if i.first(1) == "T" {
                current = Int(i.sansFirst(5).sansLast(1))!
                tiles[current] = []
            } else if i != "" {
                tiles[current]!.append(i)
            }
        }
    }
    
    for t in tiles {
        let left = String(t.value.map { $0.first! })
        let right = String(t.value.map { $0.last! })
        bords[t.key] = [t.value.first!, t.value.last!, left, right]
    }
    
//    for b1 in bords {
//        var co = 0
//        for b2 in bords {
//            if b1.key != b2.key {
//                for side in b1.value {
//                    if b2.value.contains(side) || b2.value.contains(String(side.reversed())) {
//                        co += 1
//                    }
//                }
//            }
//        }
//        if co == 2 { print(b1.key)
//        }
//    }
    
    func trim(_ tile: [String]) -> [String] {
        let newT: [String] = tile.slice(start: 1, len: 8)
        var nnT: [String] = []
        for line in newT {
            nnT.append(String(line.slice(start: 1, len: 8)))
        }
        return nnT
    }
    
    func rotate(_ tile: [String], _ n: Int) -> [String] {
        if n == 0 { return tile }
        else if n == 2 { return tile.reversed().map({ String($0.reversed()) }) }
        else {
            var newT: [String] = Array(tile.last!).map { String($0) }
            for i in 2...(tile.count) {
                for j in 0..<newT.count {
                    newT[j].append(tile[tile.count-i][j])
                }
            }
            if n == 3 { return newT.reversed().map({ String($0.reversed()) }) }
            return newT
        }
    }
    
//    func rotateAndTrim(_ key: Int, _ match: String, _ newLine: Bool) -> [String] {
//        var tile = tiles[key]!
//        var bo = bords[key]!
//
//        if newLine {
//            if match == bo[0] {
//                return trim(tile)
//            }
//        }
//        return []
//    }
//
    var fit = [2111]
    var next: String = String(bords[2111]![0].reversed())
    var next2: String = String(bords[2111]![3].reversed())
    var pic: [String] = trim(rotate(tiles[2111]!,1))
//    for l in 0..<10 {
//        pic[l].append(" ")
//    }
    var old = 0
    while fit.count < 144 {
        if fit.count == old {
            print("failure", fit.count, fit.last!, next)
            break
        } else { old = fit.count }
        for b in bords {
            if !fit.contains(b.key) {
                if b.value.contains(next) || b.value.contains(String(next.reversed())) {
                    var new = tiles[b.key]!
                    let newLine = fit.count % 12 == 0
                    lop: for _ in 0..<2 {
                        for _ in 0..<4 {
//                            print("loopin", new)
                            if new[0] == next {
                                if newLine {
                                    pic.append(contentsOf: trim(new))
                                    fit.append(b.key)
                                    next = String(new.map({ $0.last! }).reversed())
//                                    print("woei", next, new)
                                    next2 = new.last!
                                } else {
                                    new = rotate(new, 3)
                                    let s = trim(new)
                                    for i in 1...8 {
                                        pic[pic.count-i].append(s[8-i])
                                    }
                                    fit.append(b.key)
                                    if fit.count % 12 == 0 {
                                        next = next2
                                    } else {
                                        next = String(new.map({ $0.last! }).reversed())
                                    }
                                }
                                break lop
                            }
                            new = rotate(new, 1)
                        }
                        new = new.reversed()
                    }
                }
            }
        }
    }
    
    for l in pic {
        print(l.count > 100 ? l.first(100) : l)
    }
    
    print(tiles.count)
} // ans 1  18,449,208,814,679,  2111 2339 1693 2207

func day20b() {
    func rotate(_ tile: [String], _ n: Int) -> [String] {
        if n == 0 { return tile }
        else if n == 2 { return tile.reversed().map({ String($0.reversed()) }) }
        else {
            var newT: [String] = Array(tile.last!).map { String($0) }
            for i in 2...(tile.count) {
                for j in 0..<newT.count {
                    newT[j].append(tile[tile.count-i][j])
                }
            }
            if n == 3 { return newT.reversed().map({ String($0.reversed()) }) }
            return newT
        }
    }
    var pic = sd(20)
    let monster = ["                  # ","#    ##    ##    ###"," #  #  #  #  #  #   "]

    for l in pic {
        print(l)
    }
    for l in monster {
        print(l, l.count)
    }
    var mon = 0
    for _ in 0..<2 {
        for _ in 0..<4 {
            for y in 0..<(pic.count-2) {
                for x in 0..<(pic[0].count-19) {
                    var there = true
                    li: for dy in 0..<3 {
                        for dx in 0..<20 {
                            if monster[dy][dx] == "#" {
                                if pic[y+dy][x+dx] != "#" {
                                    there = false
                                    break li
                                }
                            }
                        }
                    }
                    if there {
                        mon += 1
                    }
                }
            }
            pic = rotate(pic, 1)
        }
        pic = Array(pic.reversed())
    }
            
    print(mon)
    
    var co = 0
    for lin in pic {
        for c in lin {
            if c == "#" {
                co += 1
            }
        }
    }
    print(co)
}

//.............#...#...#...#......#.#...............#...#........#...#....#....###..#.##...#.#....
//..#...#.....#......#...#.......#....#.#......#..#.................##...##........#...####......#
//.....................#.#...#.........##...#..##..#......#.......#.....####.#.###.#..#.....##....
//....#..#....#..###..........#.............#...##....##........#...##.##......#..#...............
//#.........#........##.............#..#...#.###..#..#.#....#.....................##.....#.....#..
//.##.....#....#...##........#..#..#.#..#..#.........#.#........#........##.......#..#.....#.###..
//#....................#........#...........#.#.#.......#.#......#....#.##......#...#.##...#.....#
//#......##..#.......#..#....#...#.#.......#..#.......#...........##....##......###..##...........
//.....#..#...#.....##....................................#.....##......#...##.#....##.#.....##..#
//.#...............#.....#.#...........#.#.##......#.........#....#....##.#..#..###.....##........
//##..............#..............#.##...#..#..##.#....#..#..#.#...........####.#.#.......#.#......
//...........##..#.#...#.....##.....#.#.....##...##.#.......#.......#.....#.....##......#.........
//...........#.#..#................#####.#....#...##..#.#.#......#.#.#...#...#..#.#..#.#..#..#....
//#........##...#.........#........#....#........#.##..#..#.........###......#.#..#..###..#.#..#.#
//..........##.##.......#...#...#............#......#..#.#......#....#.##..#.......#.##..##.....#.
//.#.#.......##.........#....................##..#.....#............#..#...#..##.#...#....#....#..
//..##.................#.##.................#...#....#......#.........#.#...##..#.........#....##.
//..#.....#..##......#..#..##..#.....#........#...#...............#..##.......#...#...#....#......
//.#.#....#.......#....#...#....................###.#.............#.##......#........#..#....#....
//#.#....#...##.#.....###...#.##...###...#.##......#............#....#...#........#.....##......#.
//#..#....###.......#...##...##.#.##.#..#....#.....#..#........#......#....#.#.....#.....#.......#
//.............#.......#..#..................##...........###.#..#...........#.##....#..........#.
//..#.......#..........#...#........#........................#......#.##.....#.........#..#.#..#..
//##.....##....###......#........##......#..#.#.#...#...........##..####........#.##.#..#........#
//..#........#..#.........#...#......................#....#.......##.#..#...#....#..##.#...###....
//......###....##...#.............##.......#..#..#......#.#..#.....#.......#..######.....#..#.....
//.#.#......#..##........#........#...#.....###......#.......#.####.##......####........#.........
//.........#...................#..#.....##..................#.#.##.........#.#...........##.......
//...........#.#..##.....#.#.#.#......#..#.#......................#...........#.#...#..#.#........
//#.........###..#..#...#....#...#...###..........##....#......#......####.#.#....#..#..#..#......
//..#.......#.......#...................#..#..#.....#..#..#.....#.#..#..#...#.........#.......#..#
//..........#....#...........#..........##..........##..#.....#......##....##.#..#.#..#......#....
//.#........##.#..###.......#...........#..##......#.#......#....#.#.#..#....#..###....#...##.....
//...#.....#......#........#.............##....#..........#.#....................#.....##.........
//.....#.#............###.#....#.#.......#..#...#.#..###......#............#....#...#.....#.......
//.....#........#....#..###.......#....#......#.#.#..#..#.....#.....#.#..#....#.#.....#....#......
//...#........#.#....#.#..#................##..#....##.....#...#.....#..###.......#.......#....#..
//..##.........#.....#....#..##...........##...###.....#.##.##.....##.##.........#...........##...
//...........#....#.##.#....#............##...#....#.......#...........#....#....#.....#..#.....#.
//.#..#...........#.##.#....#...#.##......#.#.....#.#.......#..........#..#.............##........
//........#.......##....##...#.#.......#....#..#.#...........#.##...........#.####..#...#........#
//............##...##..#...#..#....##.#......#.#..........###....#...#.....#.##.#......##..#.###..
//..#.......###...........#.#..#..###.#..#.......#...#.....#......#....##........#.##.#.#........#
//......#.#..#.#.#...#.....#..#...#..#..#.......##..#...#...#...#..#..#..#...#....##...#..........
//...............#.#..#.#.#...........#.#.##..#..##.......................#.##.#............#.#...
//.....#...#.......##...##......#..##.#..##....##.............#.##........#..##.....#...#....#..#.
//###...#.....##.##.##..#.#..##...#.....#..#...#.....#.#.#.......##....###.....#...#.#.#....#.#...
//.....#...###...#...##.......#....#...##.......##......#......#.#.#..#.##............#......#.#..
//...........#.#......#.....##......#.....#.#.#............###....#...............#.##...#....#...
//#..#....#..#.##..#.....#...........#....#..#..#..#.#.#........##.......#...#.....#.#...#........
//.........##....#.............##.#..#........##....#.....###...#.#.#.#.......#............#...#..
//....###..#..#.#.#..#.#.##..#.##.#...........#.........#....#..............#...#..#...#..........
//.#.#.#..#........#....#.#..#.#..#....##....#..................#......#......#.........##.....#..
//..###.......#...#....##.##...#.......###......#...####.##...#................#...#......###..#..
//.....#......#....#.###...#.#.##..................#..#..#.............#.#..#.....................
//............................#..........#.#...#....#.#.............#....#..........#.#..........#
//..###...#.......#...#.........#.......................................##..##.......##.....#.#...
//.....#...#.........#............##..#...##...#.#.##.#..............#..##.......#..#.##.....##...
//.#.#.............#.......#...#..#....#............#.......#.#...##............#......#...#......
//....#....#.#....##......#..#..#.#....##...#.#..#....#.....#...##..#.....#...#..#.....#....#..#..
//.#...............#......###....###..#..###.#...##...#.......#.#.......#.....#..........#.....#..
//#...#..#........##.#.....#.........#....#............#...........#.............#...........#....
//..............##.........#...........#..#.#..#.........#..#..##...#.....##..#..#........#...##..
//..#..##..#..##..........##........#..#...........#.#.......#.........#.##..####..........#.....#
//............#.............##.....#........#.#.#..##.......##....#......................#....#.##
//...#.#.#.#..#..........#.......#..#.##.......#.#......#.##..#.##......#.#............#........#.
//..#..#...###....#..............##..#####...#...##.......#....##..##......#...#......#.......#...
//.......#......#.........#........#.#....#.....#.##.####......#......#...#..#.....#..#...#..#....
//#..#.#....#........#..#..#........#...#.....#.......#..#........#..............#.#....#.........
//..#.....#.................##.#....###....#...#.#......##........##.##.#..##..............#..#...
//....#..#...........#....###...##...#....#.#...............##.#....##.#............#.#...#.#.#...
//.....#.............#....#.......#..#.......#..#.#.#........##.....#........................#....
//#..##...............#........#.##......#................#.#..#...##..##..#..................##..
//...#..............#.#....#..##...#.....#..#..............#.#..#.#.#.##..#..........#........#.##
//...#..#...#........#....#...#......#.#....##......#.................###..........##....#..#...#.
//......###.#..#...##...##.#.##..#...............##.....#....#...........##..#..#.#.###.#......#..
//##..#...#.###...##.#..###.#..#........#...#....#.....#.....#...#..#.#....##.##.#...#...#.#...#.#
//......#....#....#..#.........................#..#..#..#..#.....#...........##.#...###.....#.#...
//..........#...........#...#........#...#........#......#...........#.................#....#..#..
//.#.........#.................#.........#.#..#.....##...#...#...#...........##........#...#.##...
//............#......##..##........##...#........#.####.#.#..#..##.#..#........#..##...##.......#.
//..#...........#..#..#....#..#..##............#..#.###..#.##....##..#.....##......#..#.##.#...#..
//.....#..#.....##....#....###...#..#.#...........#..#.......#..#..#.........................#....
//..##..............#....#.....###.....##....##.....#.#....#.....##.......................#.#..#..
//....................##..#..#..#.............#..#..#.....#....#..#.........#.....................
//...#...........#.#.####.........##....#...##....##.#.............#....................#....#...#
//..........#....#..#...#.....#.....#..#.#...##..#..###.#.#.##.##.##...##....#..#..#........#.....
//.#.......#...#......#....#.#...........#...#..#..#...#..##....##.#..#...###....#.....#.....#.#..
//.....#.#.....#.#.....#.#.............#..............##.......#..##.#..#...#...............#.....
//....#...#....###...#.###.#.....#..#..#......#........#............#....#....#.......#...........
//....#........#...##.....#...#..#.....#..#........#.#......#..#...#.....#....#.###.#.#.........#.
//..#...........#..........#....#..##..#.....#..##......#....##..........#.........#..............
//........#.........................##..#........##....##.......#..#...#......#...#..#...........#
//.#....#.....#........#.....#.........##...#..###.#.##..##.#.....#.......#..#.....#.#....#.#.....
//..#...........#.......#.#.#.....#...#......#.....#.###....#...#.......#.......#...#........#....
//....#.#...........#....#....#.......#..............#....#..#..#.....##...#...#...........#...#..
