import Foundation

var list = gd()

for e in list.filter({ $0.opr != "acc" }) {
    list[e.num].opr.swap("nop","jmp")
    if run(list).end == list.count { break }
    list[e.num].opr.swap("nop","jmp")
}

print(run(gd()).acc,run(list).acc)



