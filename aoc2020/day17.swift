//
//  day17.swift
//  aoc2020
//
//  Created by 4 on 12/16/20.
//

import Foundation

func day17() {
    let state = sd(17)
    
    let converter = [0,1,1,2,1,2,2,3]
    
    let blank1: [[Int]] = Array(repeating: Array(repeating: 0, count: 22), count: 15)
    let blank2: [[[Int]]] = Array(repeating: Array(repeating: Array(repeating: 0, count: 22), count: 15), count: 15)

    var bounds = [(6,8),(6,14)]
    var space1 = blank1
    var newSpace1 = blank1
    var space2 = blank2
    var newSpace2 = blank2
    
    for (y, line) in state.enumerated() {
        space1[7][y+7] = Int(line.map({ $0 == "#" ? "1" : "0" }).joined(), radix: 2)! &<< 7
        space2[7][7][y+7] = Int(line.map({ $0 == "#" ? "1" : "0" }).joined(), radix: 2)! &<< 7
    }
    
    for _ in 0..<6 {
        for w in bounds[0].0...bounds[0].1 {
            for z in bounds[0].0...bounds[0].1 {
                for y in bounds[1].0...bounds[1].1 {
                    for x in bounds[1].0...bounds[1].1 {
                        var num1 = 0
                        var num2 = 0
                        var dw = -1
                        while dw < 2 {
                            var dz = -1
                            while dz < 2 {
                                var dy = -1
                                while dy < 2 {
                                    let t = (y: y+dy, z: z+dz, w: w+dw)
                                    num2 += converter[(space2[t.w][t.z][t.y] &>> (x-1)) & 7]
                                    if w == 7 && dw == 0 {
                                        num1 += converter[(space1[t.z][t.y] &>> (x-1)) & 7]
                                    }
                                    dy += 1
                                }
                                dz += 1
                            }
                            dw += 1
                        }
                        if w == 7 {
                            newSpace1[z][y] |= num1 == 3 ? 1 &<< x : 0
                            if ((space1[z][y] &>> x) & 1) == 1 && num1 == 4 {
                                newSpace1[z][y] |= 1 &<< x
                            }
                        }
                        
                        newSpace2[w][z][y] |= num2 == 3 ? 1 &<< x : 0
                        if ((space2[w][z][y] &>> x) & 1) == 1 && num2 == 4 {
                            newSpace2[w][z][y] |= 1 &<< x
                        }
                    }
                }
            }
        }
        bounds = [(bounds[0].0-1, bounds[0].1+1),(bounds[1].0-1, bounds[1].1+1)]
        
        space1 = newSpace1
        newSpace1 = blank1
        
        space2 = newSpace2
        newSpace2 = blank2
    }
    
    var n1 = 0
    var n2 = 0
    for w in bounds[0].0...bounds[0].1 {
        for z in bounds[0].0...bounds[0].1 {
            for y in bounds[1].0...bounds[1].1 {
                while space2[w][z][y] != 0 {
                    n2 += converter[space2[w][z][y]&7]
                    space2[w][z][y] = space2[w][z][y] &>> 3
                }
                if w == 7 {
                    while space1[z][y] != 0 {
                        n1 += converter[space1[z][y]&7]
                        space1[z][y] = space1[z][y] &>> 3
                    }
                }
            }
        }
    }
    
    print("17:", n1, n2)
}
