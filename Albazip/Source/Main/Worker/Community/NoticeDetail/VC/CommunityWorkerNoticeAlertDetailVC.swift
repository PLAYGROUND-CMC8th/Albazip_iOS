//
//  CommunityWorkerNoticeAlertDetailVC.swift
//  Albazip
//
//  Created by 김수빈 on 2021/11/24.
//
protocol CommunityWorkerNoticeAlertDetailDelegate {
    func successReport()
}
import Foundation

class CommunityWorkerNoticeAlertDetailVC: UIViewController{
   
    var transparentView = UIView()
    @IBOutlet var cornerView: UIView!
    @IBOutlet var view1: UIView!
    @IBOutlet var view2: UIView!
    @IBOutlet var view3: UIView!
    @IBOutlet var view4: UIView!
    @IBOutlet var view5: UIView!
    @IBOutlet var backgroundView: UIView!
    var reportType = ""
    var noticeId = -1
    var delegate: CommunityWorkerNoticeAlertDetailDelegate?
    // Datamanager
    lazy var dataManager: CommunityWorkerReportDatamanager = CommunityWorkerReportDatamanager()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //
        
        let window = UIApplication.shared.windows.filter {$0.isKeyWindow}.first
        transparentView.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        transparentView.frame = self.view.frame
        window?.addSubview(transparentView)
        //
        cornerView.roundCorners(cornerRadius: 20, maskedCorners: [.layerMinXMinYCorner, .layerMaxXMinYCorner])
        // view 클릭 시, 함수 정의
        let tapGestureRecognizer1 = UITapGestureRecognizer(target: self, action: #selector(view1Tapped))
        view1.addGestureRecognizer(tapGestureRecognizer1)
        
        let tapGestureRecognizer2 = UITapGestureRecognizer(target: self, action: #selector(view2Tapped))
        view2.addGestureRecognizer(tapGestureRecognizer2)
        
        let tapGestureRecognizer3 = UITapGestureRecognizer(target: self, action: #selector(view3Tapped))
        view3.addGestureRecognizer(tapGestureRecognizer3)
        
        let tapGestureRecognizer4 = UITapGestureRecognizer(target: self, action: #selector(view4Tapped))
        view4.addGestureRecognizer(tapGestureRecognizer4)
        
        let tapGestureRecognizer5 = UITapGestureRecognizer(target: self, action: #selector(view5Tapped))
        view5.addGestureRecognizer(tapGestureRecognizer5)
        
        let tapGestureRecognizer6 = UITapGestureRecognizer(target: self, action: #selector(backgroundViewTapped))
        backgroundView.addGestureRecognizer(tapGestureRecognizer6)
    }
    @objc func view1Tapped(sender: UITapGestureRecognizer) {
        view1.backgroundColor = #colorLiteral(red: 0.9994661212, green: 0.979791224, blue: 0.9194086194, alpha: 1)
        setReportType(text : "욕설/비하")
    }
    
    @objc func view2Tapped(sender: UITapGestureRecognizer) {
        view2.backgroundColor = #colorLiteral(red: 0.9994661212, green: 0.979791224, blue: 0.9194086194, alpha: 1)
        setReportType(text : "음란물/불건전한 대화")
    }
    
    @objc func view3Tapped(sender: UITapGestureRecognizer) {
        view3.backgroundColor = #colorLiteral(red: 0.9994661212, green: 0.979791224, blue: 0.9194086194, alpha: 1)
        setReportType(text : "낚시/놀람/도배")
    }
    
    @objc func view4Tapped(sender: UITapGestureRecognizer) {
        view4.backgroundColor = #colorLiteral(red: 0.9994661212, green: 0.979791224, blue: 0.9194086194, alpha: 1)
        setReportType(text : "유출/사칭/사기")
    }
    
    @objc func view5Tapped(sender: UITapGestureRecognizer) {
        view5.backgroundColor = #colorLiteral(red: 0.9994661212, green: 0.979791224, blue: 0.9194086194, alpha: 1)
        setReportType(text : "게시판 성격에 부적절함")
    }
    
    func setReportType(text : String)  {
        //api 호출
        let input = CommunityWorkerReportRequest(noticeId: noticeId, reportReason: text)
        showIndicator()
        dataManager.postCommunityWorkerReport(input, delegate: self)
        /*
        modalDelegate?.modalDismiss()
        modalDelegate?.textFieldData(data: text)
        transparentView.isHidden = true
        self.dismiss(animated: true, completion: nil)
 */
    }
    @objc func backgroundViewTapped(sender: UITapGestureRecognizer) {
        transparentView.isHidden = true
     
        self.dismiss(animated: true, completion: nil)
    }
}
extension CommunityWorkerNoticeAlertDetailVC{
    //공지사항 신고 api
    func didSuccessCommunityWorkerReport(result: CommunityWorkerReportResponse){
        print(result)
        dismissIndicator()
     
        transparentView.isHidden = true
        delegate?.successReport()
        self.dismiss(animated: true, completion: nil)
    }
    
    func failedToCommunityWorkerReport(message: String) {
        dismissIndicator()
        presentAlert(title: message)
    }
}
