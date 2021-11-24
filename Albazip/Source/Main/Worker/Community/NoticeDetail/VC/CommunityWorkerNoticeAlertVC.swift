//
//  CommunityWorkerNoticeAlertVC.swift
//  Albazip
//
//  Created by 김수빈 on 2021/11/24.
//

import Foundation
class CommunityWorkerNoticeAlertVC: UIViewController{
    
    var modalDelegate : ModalDelegate?
    @IBOutlet var view1: UIStackView!
    @IBOutlet var backgroundView: UIView!
    @IBOutlet var conerView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        conerView.roundCorners(cornerRadius: 20, maskedCorners: [.layerMinXMinYCorner, .layerMaxXMinYCorner])
        // view 클릭 시, 함수 정의
        let tapGestureRecognizer1 = UITapGestureRecognizer(target: self, action: #selector(view1Tapped))
        view1.addGestureRecognizer(tapGestureRecognizer1)
        let tapGestureRecognizer2 = UITapGestureRecognizer(target: self, action: #selector(backgroundViewTapped))
        backgroundView.addGestureRecognizer(tapGestureRecognizer2)
    }
    @objc func view1Tapped(sender: UITapGestureRecognizer) {
        view1.backgroundColor = #colorLiteral(red: 0.9994661212, green: 0.979791224, blue: 0.9194086194, alpha: 1)
        goReportPage()
    }
    @objc func backgroundViewTapped(sender: UITapGestureRecognizer) {
        modalDelegate?.modalDismiss()
        self.dismiss(animated: true, completion: nil)
    }
    func goReportPage()  {
        //modalDelegate?.modalDismiss()
        if let vc = self.storyboard?.instantiateViewController(withIdentifier: "CommunityWorkerNoticeAlertDetailVC") as? CommunityWorkerNoticeAlertDetailVC {
            vc.modalPresentationStyle = .overFullScreen
            modalDelegate?.modalDismiss()
        guard let pvc = self.presentingViewController else { return }
        self.dismiss(animated: false)
            {
          pvc.present(vc, animated: false, completion: nil)
        }
            
        }
    }
}
