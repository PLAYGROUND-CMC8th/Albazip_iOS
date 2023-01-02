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
class MyPageManagerSelectInfo3TableViewCell: UITableViewCell{

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
        moneyTextField.addTarget(self, action: #selector(self.textFieldDidChange(_:)),  for: .editingChanged)
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func btnPayType(_ sender: Any) {
        //급여 선택 페이지로
        myPageManagerPayTypeModalDelegate?.goSelectPayType()
    }
    @objc func textFieldDidChange(_ sender: Any?) {
           print(self.moneyTextField.text!)
        let currentMoney = (moneyTextField.text ?? "").replace(target: ",", with: "")
        moneyTextField.text = currentMoney.insertComma
        myPageManagerPayTypeModalDelegate?.checkValue3(text: self.moneyTextField.text!)
        
    }
}

