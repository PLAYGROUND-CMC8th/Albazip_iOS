//
//  MyPageManagerWorkerDirectExitVC.swift
//  Albazip
//
//  Created by 김수빈 on 2021/12/12.
//

import Foundation
class MyPageManagerWorkerDirectExitVC:UIViewController{
    @IBOutlet var titleLabel: UILabel!
    var name = ""
    var transparentView = UIView()
    // 이전 뷰에서 받아올 정보
    var positionId = 0
    var delegate: MyPageManagerWorkerExitDelegate?
    lazy var datamanager :MyPageStopWorkDatamanager = MyPageStopWorkDatamanager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleLabel.text = "정말 \(name)님을 퇴사시키겠어요?"
        let window = UIApplication.shared.windows.filter {$0.isKeyWindow}.first
        transparentView.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        transparentView.frame = self.view.frame
        window?.addSubview(transparentView)
    }
    @IBAction func btnCancel(_ sender: Any) {
        self.transparentView.isHidden = true
        self.dismiss(animated: true)
    }
    
    @IBAction func btnNext(_ sender: Any) {
        showIndicator()
         datamanager.deleteMyPageStopWork( positionId: positionId, vc: self)
    }
}
extension MyPageManagerWorkerDirectExitVC {
    //퇴사하기 api
    func didSuccessMyPageStopWork(result: MyPageStopWorkResponse) {
    
        print(result.message!)
        //profileImage.image = .none
       
        dismissIndicator()
        delegate?.successExitWork()
        self.transparentView.isHidden = true
        self.dismiss(animated: true)
    }
    
    func failedToRequestMyPageStopWork(message: String) {
        dismissIndicator()
        presentAlert(title: message)
    }
}
