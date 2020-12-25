import Foundation

func isValid(_ field: String) -> Bool {
    let data = field.sansFirst(4)
    switch field.first(3) {
    case "byr": return (Int(data) ?? 0).isin(1920...2002)
    case "iyr": return (Int(data) ?? 0).isin(2010...2020)
    case "eyr": return (Int(data) ?? 0).isin(2020...2030)
    case "hgt": return (Int(data.dropLast(2)) ?? 0).isin(range[data.last(2)])
    case "hcl": return data.filter({!$0.isHexDigit}) == "#" && data.count == 7
    case "ecl": return data.isin(["amb","blu","brn","gry", "grn", "hzl", "oth"])
    case "pid": return Int(data) != nil && data.count == 9
    default: return false
    }
}

let passes = sd().split(separator: "").map { $0.joined(separator: " ") }
let range = ["cm": 150...193, "in": 59...76]
let reqFields = Set(["byr","iyr","eyr","hgt","hcl","ecl","pid"])
print(passes.reduce((0,0)) { a, pass in
    let rem = pass.fullSplit(separator: " ").reduce((7,7)) { r,f in
        (r.0 - f.first(3).isin(reqFields).int, r.1 - isValid(f).int)
    }
    return (a.0 + (rem.0 == 0).int, a.1 + (rem.1 == 0).int)
})
