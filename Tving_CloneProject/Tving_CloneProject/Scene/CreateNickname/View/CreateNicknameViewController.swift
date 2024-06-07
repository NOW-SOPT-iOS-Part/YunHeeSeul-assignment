//
//  CreateNicknameViewController.swift
//  Tving_CloneProject
//
//  Created by 윤희슬 on 4/10/24.
//

import UIKit

import SnapKit
import Then
import RxSwift
import RxCocoa

protocol CreateNicknameVCDelegate: AnyObject {
    func saveUserNickname(nickname: String)
}

final class CreateNicknameViewController: UIViewController {
    
    // MARK: - UI Properties
    
    private let createNicknameView = CreateNicknameView()
    
    
    // MARK: - Properties
    
    var isActivate: Bool = false {
        didSet {
            self.createNicknameView.warningLabel.isHidden = isActivate
            self.createNicknameView.setSaveButton(isEnabled: isActivate)
        }
    }
    
    weak var delegate: CreateNicknameVCDelegate?
    
    private let createNicknameViewModel = CreateNicknameViewModel()
    
    private let disposeBag = DisposeBag()

    
    // MARK: - Life Cycles
    
    override func loadView() {
        self.view = createNicknameView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setStyle()
        setCreateNicknameView()
        setViewModel()
        didTapSaveButton()
    }

}


// MARK: - Private Methods

private extension CreateNicknameViewController {
    
    func setStyle() {
        self.view.backgroundColor = UIColor.clear
        self.navigationController?.navigationBar.isHidden = true
        self.tabBarController?.tabBar.isHidden = true
    }
    
    func setCreateNicknameView() {
        createNicknameView.do {
            let gesture = UITapGestureRecognizer(target: self, action: #selector(didTapDimmedView))
            $0.dimmedView.isUserInteractionEnabled = true
            $0.dimmedView.addGestureRecognizer(gesture)
        }
    }
    
    func setViewModel() {
        let input = CreateNicknameViewModel.Input(
            nicknameTextfieldDidChangeEvent: createNicknameView.nicknameTextField.rx.text.asObservable()
        )
        
        let output = createNicknameViewModel.transform(from: input, disposeBag: disposeBag)
        
        output.isValid.subscribe(onNext: { [weak self] isValid in
            self?.isActivate = isValid ? true : false
        }).disposed(by: disposeBag)
        
        output.errMessage.subscribe(onNext: { [weak self] errMessage in
            self?.createNicknameView.warningLabel.text = errMessage
        }).disposed(by: disposeBag)
    }

    func didTapSaveButton() {
        createNicknameView.saveButton.rx.tap.subscribe(onNext:  { _ in
            if self.isActivate {
                guard let nickname  = self.createNicknameView.nicknameTextField.text else { return }
                self.delegate?.saveUserNickname(nickname: nickname)
                self.dismiss(animated: true)
            }
        }).disposed(by: disposeBag)
    }
    
    @objc
    func didTapDimmedView(sender: UITapGestureRecognizer) {
        self.dismiss(animated: true)
    }
    
}
