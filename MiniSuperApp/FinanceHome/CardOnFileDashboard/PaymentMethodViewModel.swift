//
//  PaymentMethodViewModel.swift
//  MiniSuperApp
//
//  Created by Jingyu Kim on 2022/11/01.
//

import Foundation
import UIKit

struct PaymentMethodViewModel {
    let name: String
    let digits: String
    let color: UIColor
    
    init(_ paymentMethod: PaymentMethod) {
        name = paymentMethod.name
        digits = "**** \(paymentMethod.digits)"
        color = .init(hex: paymentMethod.color) ?? .systemGray2
    }
}
