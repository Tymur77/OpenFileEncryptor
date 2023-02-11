//
//  array.swift
//  Falcon09
//
//  Created by Виктория on 08.02.2023.
//

import Foundation


extension Array where Element: Equatable {
    func contains(_ element: Element) -> Bool { self.contains(where: { $0 == element }) }
}

extension Sequence where Element == CGFloat {
    func sum() -> CGFloat {
        var total: CGFloat = 0
        for i in self {
            total += i
        }
        return total
    }
}
