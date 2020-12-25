import Foundation

let s = sd().map { $0.reduce(0) { x,y in x*2 + y.isin("RB").int } }
print(s.max()!,(s.min()!...s.max()!).filter({ !$0.isin(s) }).first!)

