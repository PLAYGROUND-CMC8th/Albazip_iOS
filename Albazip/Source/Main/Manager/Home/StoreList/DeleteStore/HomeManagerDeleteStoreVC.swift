//
//  HomeManagerDeleteStoreVC.swift
//  Albazip
//
//  Created by 김수빈 on 2021/11/27.
//

import Foundation
class HomeManagerDeleteStoreVC: UIViewController{
    // Datamanager
    lazy var dataManager: HomeManagerDeleteStoreDatamanager = HomeManagerDeleteStoreDatamanager()
    @IBOutlet var storeNameLabel: UILabel!
    var storeName = ""
    @IBOutlet var btnDelete: UIButton!
    @IBOutlet var btnCheck: UIButton!
    var managerId = -1
    override func viewDidLoad() {
        super.viewDidLoad()
        storeNameLabel.text = "정말 \(storeName) 삭제하시겠어요?"
    }
    @IBAction func btnCancel(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func btnCheck(_ sender: Any) {
        btnCheck.isSelected.toggle()
        if btnCheck.isSelected{
            btnDelete.backgroundColor = #colorLiteral(red: 0.2038974464, green: 0.2039384246, blue: 0.2038920522, alpha: 1)
        }else{
            btnDelete.backgroundColor = #colorLiteral(red: 0.6234663725, green: 0.6235736609, blue: 0.6234522462, alpha: 1)
        }
    }
    @IBAction func btnCancel2(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func btnDelete(_ sender: Any) {
        if btnCheck.isSelected{
            //삭제 api 호출
            showIndicator()
            dataManager.deleteStore(managerId: managerId, vc: self)
        }else{
            presentBottomAlert(message: "먼저 약관을 읽어보시고, 약관에 동의해주세요")
        }
    }
}
extension HomeManagerDeleteStoreVC {
    func didSuccessHomeManagerDeleteStore(result: HomeManagerDeleteStoreResponse) {
        print(result.message)
        
        dismissIndicator()
        let newStoryboard = UIStoryboard(name: "StartStoryboard", bundle: nil)
                let newViewController = newStoryboard.instantiateViewController(identifier: "StartNavigationViewController")
                self.changeRootViewController(newViewController)
    }
    
    func failedToRequestHomeManagerDeleteStore(message: String) {
        dismissIndicator()
        presentAlert(title: message)
    }
}
