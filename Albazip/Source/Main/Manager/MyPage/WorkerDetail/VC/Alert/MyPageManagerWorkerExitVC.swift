//
//  MyPageManagerWorkerExitVC.swift
//  Albazip
//
//  Created by 김수빈 on 2021/11/14.
//
protocol MyPageManagerWorkerExitDelegate {
    func successExitWork()
    func cancelExitWork()
}
import Foundation
class MyPageManagerWorkerExitVC: UIViewController{
    @IBOutlet var titleLabel: UILabel!
    var name = ""
    var transparentView = UIView()
    // 이전 뷰에서 받아올 정보
    var positionId = 0
    var delegate: MyPageManagerWorkerExitDelegate?
    lazy var datamanager :MyPageStopWorkDatamanager = MyPageStopWorkDatamanager()
    lazy var datamanager2 :MyPageStopWorkCancelDatamanager = MyPageStopWorkCancelDatamanager()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleLabel.text = "\(name)님이 퇴사 요청을 보냈어요."
        let window = UIApplication.shared.windows.filter {$0.isKeyWindow}.first
        transparentView.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        transparentView.frame = self.view.frame
        window?.addSubview(transparentView)
    }
    //퇴사 거절 api
    @IBAction func btnCancel(_ sender: Any) {
        showIndicator()
         datamanager2.cancelMyPageStopWork( positionId: positionId, vc: self)
    }
    //퇴사하기 api
    @IBAction func btnNext(_ sender: Any) {
       showIndicator()
        datamanager.deleteMyPageStopWork( positionId: positionId, vc: self)
    }
}
extension MyPageManagerWorkerExitVC {
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
    
    //퇴사 거절 api
    func didSuccessMyPageStopWorkCancel(result: MyPageStopWorkCancelResponse) {
    
        print(result.message!)
        //profileImage.image = .none
       
        dismissIndicator()
        delegate?.cancelExitWork()
        self.transparentView.isHidden = true
        self.dismiss(animated: true)
    }
    
    func failedToRequestMyPageStopWorkCancel(message: String) {
        dismissIndicator()
        presentAlert(title: message)
    }
}
