//
//  HomeManagerQRCodeVC.swift
//  Albazip
//
//  Created by 김수빈 on 2021/11/13.
//

import Foundation
class HomeManagerQRCodeVC: UIViewController{
    
    @IBOutlet var storeNameLabel: UILabel!
    @IBOutlet var qrImage: UIImageView!
    var storeName = ""
    lazy var dataManager: HomeManagerQRCodeDatamanager = HomeManagerQRCodeDatamanager()
    override func viewDidLoad() {
        super.viewDidLoad()
        storeNameLabel.text = storeName
        showIndicator()
        dataManager.downloadWeatherIcon("soobin",vc: self)
    }
    
    @IBAction func btnCancel(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func btnDownLoad(_ sender: Any) {
        UIImageWriteToSavedPhotosAlbum(qrImage.image!, self, nil, nil)
        presentBottomAlert(message: "이미지를 다운로드 했습니다.")
    }
}
extension HomeManagerQRCodeVC{
    func didHomeManagerQRCode(result: UIImage){
        qrImage.image = result
        dismissIndicator()
    }
    func failedHomeManagerQRCode(message: String){
        presentAlert(title: message)
        dismissIndicator()
    }
}
