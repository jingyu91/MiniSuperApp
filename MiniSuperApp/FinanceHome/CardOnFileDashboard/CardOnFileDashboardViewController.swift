//
//  CardOnFileDashboardViewController.swift
//  MiniSuperApp
//
//  Created by Jingyu Kim on 2022/11/01.
//

import ModernRIBs
import UIKit

protocol CardOnFileDashboardPresentableListener: AnyObject {
    // TODO: Declare properties and methods that the view controller can invoke to perform
    // business logic, such as signIn(). This protocol is implemented by the corresponding
    // interactor class.
}

final class CardOnFileDashboardViewController: UIViewController, CardOnFileDashboardPresentable, CardOnFileDashboardViewControllable {

    weak var listener: CardOnFileDashboardPresentableListener?
    
    private let headerStackView = UIStackView().then {
        $0.alignment = .fill
        $0.distribution = .equalSpacing
        $0.axis = .horizontal
    }
    
    private let titleLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 22, weight: .semibold)
        $0.text = "카드 및 계좌"
    }
    
    private lazy var seeAllButton = UIButton().then {
        $0.setTitle("전체보기", for: .normal)
        $0.setTitleColor(.systemBlue, for: .normal)
        $0.addTarget(self, action: #selector(seeAllButtonDidTap), for: .touchUpInside)
    }
    
    private let cardOnFileStackView = UIStackView().then {
        $0.alignment = .fill
        $0.distribution = .equalSpacing
        $0.axis = .vertical
        $0.spacing = 12
    }
    
    private lazy var addMethodButton = AddPaymentMethodButton().then {
        $0.roundCorners()
        $0.backgroundColor = .systemGray4
        $0.addTarget(self, action: #selector(addButtonDidTap), for: .touchUpInside)
    }
    
    init() {
        super.init(nibName: nil, bundle: nil)
        
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        view.addSubview(headerStackView)
        view.addSubview(cardOnFileStackView)
        
        headerStackView.addArrangedSubview(titleLabel)
        headerStackView.addArrangedSubview(seeAllButton)
        
        headerStackView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(10)
            $0.leading.trailing.equalToSuperview().inset(20)
        }
        
        cardOnFileStackView.snp.makeConstraints {
            $0.top.equalTo(headerStackView.snp.bottom).offset(10)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.bottom.equalToSuperview()
        }
        
        addMethodButton.snp.makeConstraints {
            $0.height.equalTo(60)
        }
    }
    
    func update(with viewModels: [PaymentMethodViewModel]) {
        cardOnFileStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
        
        let views = viewModels.map(PaymentMethodView.init)
        views.forEach {
            $0.roundCorners()
            cardOnFileStackView.addArrangedSubview($0)
        }
        
        cardOnFileStackView.addArrangedSubview(addMethodButton)
        let heightConstraints = views.map { $0.heightAnchor.constraint(equalToConstant: 60) }
        NSLayoutConstraint.activate(heightConstraints)
    }
    
    
    @objc func seeAllButtonDidTap() {
        
    }
    
    @objc func addButtonDidTap() {
        
    }
}
