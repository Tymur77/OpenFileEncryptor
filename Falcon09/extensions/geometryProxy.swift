//
//  geometryProxy.swift
//  Falcon09
//
//  Created by Виктория on 04.02.2023.
//

import Foundation
import SwiftUI

extension GeometryProxy {
    var center: CGPoint { CGPoint(x: self.size.width/2, y: self.size.height/2) }
}
