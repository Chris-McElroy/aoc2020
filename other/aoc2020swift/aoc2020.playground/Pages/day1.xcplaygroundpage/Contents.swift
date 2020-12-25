import Foundation

//let set = Set(id())
//
//print(1010**2-(1010-set.first(where: { (2020-$0).isin(set) })!)**2)
//
//for i in set {
//    if let j = set.first(where: { set.contains(2020-i-$0) }) {
//        print(i*j*(2020-i-j))
//        break
//    }
//}

print(id().twoSumTo(2020)!.product(),id().nSumTo(2020, n: 3)!.product())
