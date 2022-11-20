//
//  CardOnFileRepository.swift
//  MiniSuperApp
//
//  Created by Jingyu Kim on 2022/11/01.
//

import Foundation

protocol CardOnFileRepository {
    var cardOnFile: ReadOnlyCurrentValuePublisher<[PaymentMethod]> { get }
}

class CardOnFileRepositoryImp: CardOnFileRepository {
    var cardOnFile: ReadOnlyCurrentValuePublisher<[PaymentMethod]> { paymentMethodSubject }
    
    private let paymentMethodSubject = CurrentValuePublisher<[PaymentMethod]>([
        PaymentMethod(id: "0", name: "우리은행", digits: "0123", color: "#f19a38ff", isPrimary: false),
        PaymentMethod(id: "1", name: "신한은행", digits: "4512", color: "#356138ff", isPrimary: false),
        PaymentMethod(id: "2", name: "현대카드", digits: "5244", color: "#89afd2ff", isPrimary: false),
        PaymentMethod(id: "3", name: "국민은행", digits: "1122", color: "#876dc9ff", isPrimary: false),
//        PaymentMethod(id: "4", name: "카카오뱅크", digits: "5672", color: "#ffcc00ff", isPrimary: false),
    ])
}
