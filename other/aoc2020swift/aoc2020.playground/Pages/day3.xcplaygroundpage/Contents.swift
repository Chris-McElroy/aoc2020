import Foundation

let w = [1,3,5,7,0.5].map { d in
    sd().enumerated().reduce(0) { t,l in
        t + (l.element[w: (d*Double(l.offset)).int] == "#").int
    }
}

print(w, w.product())
