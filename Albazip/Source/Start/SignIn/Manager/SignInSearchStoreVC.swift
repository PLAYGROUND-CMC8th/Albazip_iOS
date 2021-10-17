//
//  SignInSearchStoreVC.swift
//  Albazip
//
//  Created by 김수빈 on 2021/10/17.
//

import UIKit

class SignInSearchStoreVC: UIViewController{
    
    @IBOutlet weak var alertLabel: UILabel!
    @IBOutlet weak var searchTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI()
        
    }
    
    func setUI(){
        let attrString = NSMutableAttributedString(string: alertLabel.text!)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 4
        attrString.addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphStyle, range: NSMakeRange(0, attrString.length))
        alertLabel.attributedText = attrString
        searchTextField.addLeftPadding()
    }
}
