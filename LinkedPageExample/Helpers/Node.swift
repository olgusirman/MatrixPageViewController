//
//  Node.swift
//  LinkedPageExample
//
//  Created by Olgu on 5.02.2020.
//  Copyright © 2020 Aspendos IT. All rights reserved.
//

struct Node: CustomStringConvertible {
    
    var x: Int = 0
    var y: Int = 0
    
    init(x: Int, y: Int) {
        self.x = x
        self.y = y
    }
    
    var description: String {
        return "(\(x),\(y))"
    }
}

extension Node: Equatable {
    static func == (lhs: Node, rhs: Node) -> Bool {
        return (lhs.x == rhs.x) && (lhs.y == rhs.y)
    }
}
