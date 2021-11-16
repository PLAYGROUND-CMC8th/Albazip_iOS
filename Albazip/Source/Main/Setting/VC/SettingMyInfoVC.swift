//
//  SettingMyInfoVC.swift
//  Albazip
//
//  Created by 김수빈 on 2021/11/10.
//

import Foundation
import UIKit

class SettingMyInfoVC: UIViewController{
    
    @IBOutlet var phoneNumberLabel: UILabel!
    @IBOutlet var genderLabel: UILabel!
    @IBOutlet var yearLabel: UILabel!
    @IBOutlet var nameLabel: UILabel!
    lazy var dataManager: SettingMyInfoDatamanager = SettingMyInfoDatamanager()
    //MARK:- Data Source
    var myInfo: SettingMyInfoData?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showIndicator()
        dataManager.getSettingMyInfo(vc: self)
    }
    @IBAction func btnCancel(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnEditInfo(_ sender: Any) {
        guard let nextVC = self.storyboard?.instantiateViewController(identifier: "SettingEditBasicInfoVC") as? SettingEditBasicInfoVC else {return}
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
    
    @IBAction func btnEditPhone(_ sender: Any) {
        guard let nextVC = self.storyboard?.instantiateViewController(identifier: "SettingEditPhoneNumberVC") as? SettingEditPhoneNumberVC else {return}
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
}
extension SettingMyInfoVC {
    func didSuccessSettingMyInfo(result: SettingMyInfoResponse) {
        
        myInfo = result.data
        if let data = myInfo{
            nameLabel.text = data.lastName! + data.firstName!
            yearLabel.text = data.birthyear!
            
            if data.gender! == 0{
                genderLabel.text = "남자"
            }else{
                genderLabel.text = "여자"
            }
            phoneNumberLabel.text = data.phone!.insertPhone
        }
        print(result.message!)
        
        dismissIndicator()
        
    }
    
    func failedToRequestSettingMyInfo(message: String) {
        dismissIndicator()
        presentAlert(title: message)
        
    }
}

