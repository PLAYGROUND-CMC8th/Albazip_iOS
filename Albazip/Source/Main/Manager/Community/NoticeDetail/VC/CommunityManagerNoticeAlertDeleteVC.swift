//
//  CommunityManagerNoticeAlertDeleteVC.swift
//  Albazip
//
//  Created by 김수빈 on 2021/11/25.
//
protocol CommunityManagerNoticeAlertDeleteDelegate {
    func successDeleteNotice()
}
import Foundation
class CommunityManagerNoticeAlertDeleteVC: UIViewController{
    @IBOutlet var backgroundView: UIView!
    var transparentView = UIView()
    var modalDelegate : ModalDelegate?
    var noticeId = -1
    var delegate: CommunityManagerNoticeAlertDeleteDelegate?
    
    // Datamanager
    lazy var dataManager: CommunityManagerNoticeDeleteDatamanager = CommunityManagerNoticeDeleteDatamanager()
    @IBOutlet var cornorView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        let window = UIApplication.shared.windows.filter {$0.isKeyWindow}.first
        transparentView.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        transparentView.frame = self.view.frame
        window?.addSubview(transparentView)
        
        cornorView.roundCorners(cornerRadius: 20, maskedCorners: [.layerMinXMinYCorner, .layerMaxXMinYCorner])
        let backgroundTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(backgroundViewTapped))
                backgroundView.addGestureRecognizer(backgroundTapGestureRecognizer)
    }
    
    @IBAction func btnCancel(_ sender: Any) {
        transparentView.isHidden = true
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func btnDelete(_ sender: Any) {
        showIndicator()
        dataManager.getCommunityManagerNoticeDelete(noticeId: noticeId, vc: self)
    }
    @objc func backgroundViewTapped(sender: UITapGestureRecognizer) {
        transparentView.isHidden = true
        self.dismiss(animated: true, completion: nil)
    }
}

extension CommunityManagerNoticeAlertDeleteVC{
    //공지사항 삭제 api
    func didSuccessCommunityManagerNoticeDelete(result: CommunityManagerNoticeDeleteResponse){
        print(result)
        dismissIndicator()
        transparentView.isHidden = true
        delegate?.successDeleteNotice()
        self.dismiss(animated: true, completion: nil)
    }
    
    func failedToRequestCommunityManagerNoticeDelete(message: String) {
        dismissIndicator()
        presentAlert(title: message)
    }
}
