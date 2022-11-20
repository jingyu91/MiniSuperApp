//
//  PaymentMethod.swift
//  MiniSuperApp
//
//  Created by Jingyu Kim on 2022/11/01.
//

import Foundation

struct PaymentMethod: Decodable {
    let id: String
    let name: String
    let digits: String
    let color: String
    let isPrimary: Bool
}
