import Foundation

let list = sd().split(separator: "")
let groups = list.map { ($0.joined(separator: ""),$0.count) }
print(groups.map({ $0.0.occurs(min: 1).count }).sum())
print(groups.map({ $0.0.occurs(min: $0.1).count }).sum())


