//
//  RegisterBasicInfoVC.swift
//  Albazip
//
//  Created by 김수빈 on 2021/10/16.
//
import Foundation
import UIKit
import RxSwift
import RxCocoa

class RegisterBasicInfoVC: UIViewController{
    
    private lazy var disposeBag = DisposeBag()
    private lazy var viewModel = RegisterBasicViewModel()
    
    @IBOutlet weak var modalBgView: UIView!
    @IBOutlet weak var firstNameTextfield: UITextField!
    @IBOutlet weak var nameTextfield: UITextField!
    @IBOutlet weak var btnMan: UIButton!
    @IBOutlet weak var btnWoman: UIButton!
    @IBOutlet weak var btnNext: UIButton!
    @IBOutlet weak var btnCancel: UIButton!
    @IBOutlet weak var ageTextfield: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        setupBinding()
    }
    
    private func setupUI(){
        firstNameTextfield.addLeftPadding()
        nameTextfield.addLeftPadding()
        ageTextfield.addLeftPadding()
        
        self.dismissKeyboardWhenTappedAround()
        
        btnWoman.adjustsImageWhenHighlighted = false
        btnMan.adjustsImageWhenHighlighted = false
        
        modalBgView.alpha = 0.0
        
        firstNameTextfield.attributedPlaceholder = NSAttributedString(string: "성", attributes: [NSAttributedString.Key.font: UIFont(name: "AppleSDGothicNeo-Medium", size: 16)!])
        
        nameTextfield.attributedPlaceholder = NSAttributedString(string: "이름", attributes: [NSAttributedString.Key.font: UIFont(name: "AppleSDGothicNeo-Medium", size: 16)!])
        
        ageTextfield.attributedPlaceholder = NSAttributedString(string: "출생년도 (YYYY)", attributes: [NSAttributedString.Key.font: UIFont(name: "AppleSDGothicNeo-Medium", size: 16)!])
    }
    
    private func setupBinding(){
        // 출생년도
        ageTextfield.rx
            .controlEvent(.touchDown)
            .asDriver()
            .drive(onNext: { [weak self] in
                guard let self = self else { return }
                self.moveToSelectYearVC()
            }).disposed(by: disposeBag)
        
        ageTextfield.rx.text.orEmpty
            .bind(to: viewModel.age)
            .disposed(by: disposeBag)
        
        // 성별
        btnMan.rx.tap
            .asDriver()
            .drive(onNext: { [weak self] in
                guard let self = self else { return }
                self.viewModel.gender.accept("M")
                self.btnMan.isSelected = true
                self.btnMan.backgroundColor = .semiYellow
                self.btnMan.borderColor = .mainYellow
                self.btnWoman.isSelected = false
                self.btnWoman.backgroundColor = .none
                self.btnWoman.borderColor = #colorLiteral(red: 0.9371625781, green: 0.9373195171, blue: 0.9371418357, alpha: 1)
            })
            .disposed(by: disposeBag)
        
        btnWoman.rx.tap
            .asDriver()
            .drive(onNext: { [weak self] in
                guard let self = self else { return }
                self.viewModel.gender.accept("W")
                self.btnWoman.isSelected = true
                self.btnWoman.backgroundColor = .semiYellow
                self.btnWoman.borderColor = .mainYellow
                self.btnMan.isSelected = false
                self.btnMan.backgroundColor = .none
                self.btnMan.borderColor = #colorLiteral(red: 0.9371625781, green: 0.9373195171, blue: 0.9371418357, alpha: 1)
            })
            .disposed(by: disposeBag)
        
        // 이름
        nameTextfield.rx.text.orEmpty
            .bind(to: viewModel.firstName)
            .disposed(by: disposeBag)
        
        nameTextfield.rx.controlEvent([.editingDidBegin])
            .asDriver()
            .drive(onNext: { [weak self] in
                guard let self = self else { return }
                self.nameTextfield.borderColor = .mainYellow
            })
            .disposed(by: disposeBag)
        
        nameTextfield.rx.controlEvent([.editingDidEnd])
            .asDriver()
            .drive(onNext: { [weak self] in
                guard let self = self else { return }
                self.nameTextfield.borderColor = .lightGray
            })
            .disposed(by: disposeBag)
        
        firstNameTextfield.rx.text.orEmpty
            .bind(to: viewModel.lastName)
            .disposed(by: disposeBag)
        
        firstNameTextfield.rx.controlEvent([.editingDidBegin])
            .asDriver()
            .drive(onNext: { [weak self] in
                guard let self = self else { return }
                self.firstNameTextfield.borderColor = .mainYellow
            })
            .disposed(by: disposeBag)
        
        firstNameTextfield.rx.controlEvent([.editingDidEnd])
            .asDriver()
            .drive(onNext: { [weak self] in
                guard let self = self else { return }
                self.firstNameTextfield.borderColor = .lightGray
            })
            .disposed(by: disposeBag)
        
        // 다음 버튼
        btnNext.rx.tap
            .asDriver()
            .drive(onNext: { [weak self] in
                guard let self = self else { return }
                self.viewModel.postRegister { (data, error) in
                    if data == nil{
                        self.presentAlert(title: error ?? "")
                    }else{
                        self.moveToSelectPositionVC()
                    }
                }
            })
            .disposed(by: disposeBag)
        
        // 취소 버튼
        btnCancel.rx.tap
            .asDriver()
            .drive(onNext: { [weak self] in
                guard let self = self else { return }
                self.navigationController?.popViewController(animated: true)
            })
            .disposed(by: disposeBag)
        
        // 버튼 유효성 검사
        viewModel.isNextButtonEnable()
            .asDriver(onErrorJustReturn: false)
            .drive(onNext: { [weak self] in
                guard let self = self else { return }
                if $0{
                    self.btnNext.isEnabled = true
                    self.btnNext.backgroundColor = .enableYellow
                    self.btnNext.setTitleColor(.gray, for: .normal)
                }else{
                    self.btnNext.isEnabled = false
                    self.btnNext.backgroundColor = .disableYellow
                    self.btnNext.setTitleColor(.semiGray, for: .normal)
                }
            })
            .disposed(by: disposeBag)
    }
    
    private func moveToSelectYearVC() {
        if let vc = self.storyboard?.instantiateViewController(withIdentifier: "RegisterSelectYearVC") as? RegisterSelectYearVC {
            vc.modalPresentationStyle = .overFullScreen
            
            modalBgView.alpha = 1
            vc.delegate = self
            
            self.present(vc, animated: true, completion: nil)
        }
    }
    
    private func moveToSelectPositionVC() {
        guard let nextVC = self.storyboard?.instantiateViewController(identifier: "RegisterSelectPositionVC") as? RegisterSelectPositionVC else {return}
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
}

extension RegisterBasicInfoVC: YearModalDelegate {
    func modalDismiss() {
        self.modalBgView.alpha = 0.0
        self.view.endEditing(true)
    }
    
    func textFieldData(data: String) {
        self.ageTextfield.text = data
        self.viewModel.age.accept(data)
    }
}
