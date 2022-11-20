//
//  AddPaymentMethodButton.swift
//  MiniSuperApp
//
//  Created by Jingyu Kim on 2022/11/01.
//

import Foundation
import UIKit

final class AddPaymentMethodButton: UIControl {
    private let plusIcon = UIImageView().then {
        $0.image = UIImage(systemName: "plus", withConfiguration: UIImage.SymbolConfiguration(pointSize: 24, weight: .semibold))
        $0.tintColor = .white
    }
    
    init() {
        super.init(frame: .zero)
        
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        addSubview(plusIcon)
        
        plusIcon.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }
}
