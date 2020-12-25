import Foundation

let list = id().sorted()
var gaps = [1,0,1,1]
var vQueue = [0]
var sQueue = [1,1,1]

for e in list {
    gaps[e-vQueue.last!] += 1
    vQueue = vQueue.filter({ e-$0 <= 3 }) + [e]
    sQueue.pushOn(sQueue.last(vQueue.count-1).sum())
}

print(gaps.product(), sQueue.last!)
