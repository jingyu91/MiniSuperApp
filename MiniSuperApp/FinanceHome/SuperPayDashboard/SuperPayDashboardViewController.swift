//
//  SuperPayDashboardViewController.swift
//  MiniSuperApp
//
//  Created by Jingyu Kim on 2022/10/30.
//

import ModernRIBs
import UIKit

protocol SuperPayDashboardPresentableListener: AnyObject {
    
}

final class SuperPayDashboardViewController: UIViewController, SuperPayDashboardPresentable, SuperPayDashboardViewControllable {
    
    weak var listener: SuperPayDashboardPresentableListener?
    
    private let headerStackView = UIStackView().then {
        $0.alignment = .fill
        $0.distribution = .equalSpacing
        $0.axis = .horizontal
    }
    
    private let titleLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 22, weight: .semibold)
        $0.text = "슈퍼페이 잔고"
    }
    
    private lazy var topupButton = UIButton().then {
        $0.setTitle("충전하기", for: .normal)
        $0.setTitleColor(.systemBlue, for: .normal)
        $0.addTarget(self, action: #selector(topupButtonDidTap), for: .touchUpInside)
    }
    
    private let cardView = UIView().then {
        $0.layer.cornerRadius = 16
        $0.layer.cornerCurve = .continuous
        $0.backgroundColor = .systemIndigo
    }
    
    private let currencyLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 22, weight: .semibold)
        $0.text = "원"
        $0.textColor = .white
    }
    
    private let balanceAmountLable = UILabel().then {
        $0.font = .systemFont(ofSize: 22, weight: .semibold)
        $0.textColor = .white
    }
    
    private let balanceStackView = UIStackView().then {
        $0.axis = .horizontal
        $0.alignment = .fill
        $0.distribution = .equalSpacing
        $0.spacing = 4
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
        view.addSubview(cardView)
        cardView.addSubview(balanceStackView)
        balanceStackView.addArrangedSubview(balanceAmountLable)
        balanceStackView.addArrangedSubview(currencyLabel)
        
        headerStackView.addArrangedSubview(titleLabel)
        headerStackView.addArrangedSubview(topupButton)
        
        headerStackView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(10)
            $0.leading.trailing.equalToSuperview().inset(20)
        }
        
        cardView.snp.makeConstraints {
            $0.top.equalTo(headerStackView.snp.bottom).offset(10)
            $0.height.equalTo(180)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.bottom.equalToSuperview().inset(20)
        }
        
        balanceStackView.snp.makeConstraints {
            $0.center.equalTo(cardView)
        }
    }
    
    
    func updateBalance(balance: String) {
        balanceAmountLable.text = balance
    }
    
    @objc func topupButtonDidTap() {
        
    }
    
}
