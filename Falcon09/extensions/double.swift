//
//  double.swift
//  Falcon09
//
//  Created by Виктория on 09.02.2023.
//

import Foundation

extension Double {
    func round(_ n: Double) -> Double { (self * pow(10, n)).rounded() / pow(10, n) }
}
