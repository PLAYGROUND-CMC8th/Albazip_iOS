//
//  MyPageManagerSelectInfo3TableViewCell.swift
//  Albazip
//
//  Created by 김수빈 on 2021/11/04.
//

import UIKit
protocol MyPageManagerPayTypeModalDelegate {
    func goSelectPayType()
    func checkValue3(text: String)
}
class MyPageManagerSelectInfo3TableViewCell: UITableViewCell, UITextFieldDelegate {

    @IBOutlet var btnPayType: UIButton!
    @IBOutlet var payTypeLabel: UILabel!
    @IBOutlet var moneyTextField: UITextField!
    var myPageManagerPayTypeModalDelegate : MyPageManagerPayTypeModalDelegate?
    override func awakeFromNib() {
        super.awakeFromNib()
        setUI()
    }
    func setUI()  {
        
        moneyTextField.addRightPadding()
        moneyTextField.delegate = self
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func btnPayType(_ sender: Any) {
        //급여 선택 페이지로
        myPageManagerPayTypeModalDelegate?.goSelectPayType()
    }
    // 텍스트 필드의 편집을 시작할 때 호출
        func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
            print("텍스트 필드의 편집이 시작됩니다.")
            myPageManagerPayTypeModalDelegate?.checkValue3(text: "")
            return true // false를 리턴하면 편집되지 않는다.
        }
        
        // 텍스트 필드의 내용이 삭제될 때 호출
        func textFieldShouldClear(_ textField: UITextField) -> Bool {
            print("텍스트 필드의 내용이 삭제됩니다.")
            myPageManagerPayTypeModalDelegate?.checkValue3(text: "")
            return true // false를 리턴하면 삭제되지 않는다.
        }
        
        // 텍스트 필드 내용이 변경될 때 호출
        func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
            print("텍스트 필드의 내용이 \(string)으로 변경됩니다.")
            if string.isEmpty { // 백스페이스 감지
                if moneyTextField.text!.count != 0{
                    //let data = moneyTextField.text!.substring(from: 0, to: moneyTextField.text!.count-2)
                    //myPageManagerPayTypeModalDelegate?.checkValue3(text: "")
                }
                return true
                
            }

            
            myPageManagerPayTypeModalDelegate?.checkValue3(text:"")
            return true
        }
        
        // 텍스트 필드의 리턴키가 눌러졌을 때 호출
        func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            textField.resignFirstResponder()
            print("텍스트 필드의 리턴키가 눌러졌습니다.")
            myPageManagerPayTypeModalDelegate?.checkValue3(text: moneyTextField.text!)
            return true
        }
        
        // 텍스트 필드 편집이 종료될 때 호출
        func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
            print("텍스트 필드의 편집이 종료됩니다.")
            myPageManagerPayTypeModalDelegate?.checkValue3(text: moneyTextField.text!)
            return true
        }
        
        // 텍스트 필드의 편집이 종료되었을 때 호출
        func textFieldDidEndEditing(_ textField: UITextField) {
            print("텍스트 필드의 편집이 종료되었습니다.")
            myPageManagerPayTypeModalDelegate?.checkValue3(text: moneyTextField.text!)
            
        }

}

