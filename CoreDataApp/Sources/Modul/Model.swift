import Foundation

struct People {
    let name: String
    let birthday: String
    let gender: String
}

extension People {
    static var user: People  = People(name: "Kyle", birthday: "", gender: "man")
}
