//
//  AddPaymentMethodViewController.swift
//  MiniSuperApp
//
//  Created by Jingyu Kim on 2022/11/20.
//

import ModernRIBs
import UIKit

protocol AddPaymentMethodPresentableListener: AnyObject {
    func didTapClose()
    func didTapConfirm(with number: String, cvc: String, expiry: String)
}

final class AddPaymentMethodViewController: UIViewController, AddPaymentMethodPresentable, AddPaymentMethodViewControllable {
    
    weak var listener: AddPaymentMethodPresentableListener?
    
    private lazy var cardNumberTextField = makeTextField().then {
        $0.placeholder = "카드 번호"
    }
    
    private lazy var stackView = UIStackView().then {
        $0.axis = .horizontal
        $0.alignment = .center
        $0.distribution = .fillEqually
        $0.spacing = 14
    }
    
    private lazy var securityTextField = makeTextField().then {
        $0.placeholder = "CVC"
    }
    
    private lazy var expirationTextfield = makeTextField().then {
        $0.placeholder = "유효기한"
    }
    
    private lazy var addCardButton = UIButton().then {
        $0.roundCorners()
        $0.backgroundColor = .primaryRed
        $0.setTitle("추가하기", for: .normal)
        $0.addTarget(self, action: #selector(didTapAddCard), for: .touchUpInside)
    }
    
    private func makeTextField() -> UITextField {
        let textField = UITextField().then {
            $0.backgroundColor = .white
            $0.borderStyle = .roundedRect
            $0.keyboardType = .numberPad
        }
        
        return textField
    }
    
    init() {
        super.init(nibName: nil, bundle: nil)
        
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        setupViews()
    }
    
    func setupViews() {
        title = "카드 추가"
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            image: UIImage(
                systemName: "xmark",
                withConfiguration: UIImage.SymbolConfiguration(pointSize: 18, weight: .semibold)
            ),
            style: .plain,
            target: self,
            action: #selector(didTapClose))
        
        view.backgroundColor = .backgroundColor
        view.addSubview(cardNumberTextField)
        view.addSubview(stackView)
        view.addSubview(addCardButton)
        
        stackView.addArrangedSubview(securityTextField)
        stackView.addArrangedSubview(expirationTextfield)
        
        cardNumberTextField.snp.makeConstraints {
            $0.top.equalToSuperview().offset(40)
            $0.leading.trailing.equalToSuperview().inset(40)
            $0.bottom.equalTo(stackView.snp.top).offset(-20)
            $0.height.equalTo(60)
        }
        securityTextField.snp.makeConstraints {
            $0.height.equalTo(60)
        }
        
        stackView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(40)
            $0.bottom.equalTo(addCardButton.snp.top).offset(-20)
            $0.height.equalTo(60)
        }
        
        addCardButton.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(40)
            $0.height.equalTo(60)
        }
    }
    
    @objc func didTapAddCard() {
        if let number = cardNumberTextField.text,
           let cvc = securityTextField.text,
           let expiry = expirationTextfield.text {
            listener?.didTapConfirm(with: number, cvc: cvc, expiry: expiry)
        }
    }
    
    @objc func didTapClose() {
        listener?.didTapClose()
    }
}
