import Foundation

var list = sd()

var mask: [(Int, Int)] = []
var mem: [Int: Int] = [:]

var powes: [Int] = []

for p in 0..<36 {
    powes.append(2**p)
}

for line in list {
    if line.hasPrefix("mask") {
//        print("making mask")
        mask = []
        var i = 0
        for c in line.dropFirst(7) {
            if c == "X" {
                mask.append((i,0))
            } else if c == "1" {
                mask.append((i,1))
            } else {
                mask.append((i,2))
            }
            i += 1
        }
    } else {
        let s = line.split(separator: "=")
        var n = String(Int(s[0].dropFirst(4).dropLast(2))!, radix: 2)
        n = String(Array(repeating: "0", count: 36-n.count)) + n
        print(n, n.count)
        let k = Int(s[1].dropFirst(1))!
        var pos: [String] = [""]
        for m in mask {
            if m.1 == 1 {
                for i in 0..<pos.count {
                    pos[i] += "1"
                }
            } else if m.1 == 2 {
                for i in 0..<pos.count {
                    pos[i] += String(n.dropFirst(m.0).dropLast(n.count-m.0-1))
                }
            } else {
                for i in 0..<pos.count {
                    pos.append(pos[i] + "0")
                    pos[i] += "1"
                }
            }
        }
        for p in pos {
            mem[Int(p, radix: 2)!, default: 0] = k
        }
    }
}
print(mem,mem.values.sum())

//let s = line.split(separator: "=")
//var n = Int(s[0].dropFirst(4).dropLast(2))!
//let k = Int(s[1].dropFirst(1))!
//var pos: [Int] = []
//var vare : [Int] = []
//for m in mask {
//    if m.1 == 1 {
//        n = n|powes[m.0]
//    } else {
//        n = n&(Int.max ^ (powes[m.0]))
//        vare.append(m.0)
//    }
//}
//pos.append(n)
//for v in vare {
//    for p in pos {
//        pos.append(p + powes[v])
//    }
//}
//for p in pos {
//    mem[p, default: 0] = k
//}
