import Foundation

var list = id()
var poss = list.sansFirst(25).enumerated()
let target = poss.first(where: { (i,e) in list[i,i+25].twoSumTo(e) == nil })!.element

var start = 0
var end = 0
while list[start,end].sum() != target {
    if list[start,end].sum() > target { start += 1 }
    else { end += 1 }
}
print(target, list[start,end].min()!+list[start,end].max()!)

