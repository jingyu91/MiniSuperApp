//
//  Formatter.swift
//  MiniSuperApp
//
//  Created by Jingyu Kim on 2022/10/31.
//

import Foundation

struct Formmater {
    static let balanceFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        return formatter
    }()
}
