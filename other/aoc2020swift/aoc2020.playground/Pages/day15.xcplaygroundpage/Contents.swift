
import Foundation

var bist = [2,20,0,4,1,17]
var list: [Int: Int] = [2: 0,20: 1,0: 2,4: 3,1: 4,17: 5]
var i = 6
var next = 0

while i != 29999999 {
//    if let old = bist.dropLast().reversed().enumerated().first(where: { $0.element == bist.last! }) {
//        bist.append(old.offset+1)
//    } else {
//        bist.append(0)
//    }
//    i+=1
    let tmp = next
    next = i-list[next, default: i]
    list[tmp] = i
    i += 1
}

print(next)
