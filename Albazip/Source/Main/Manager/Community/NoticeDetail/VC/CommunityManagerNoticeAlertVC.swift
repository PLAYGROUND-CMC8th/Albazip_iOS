//
//  CommunityManagerNoticeAlertVC.swift
//  Albazip
//
//  Created by 김수빈 on 2021/11/25.
//

import Foundation
class CommunityManagerNoticeAlertVC: UIViewController{
    var modalDelegate : ModalDelegate?
    @IBOutlet var cornerView: UIView!
    @IBOutlet var backgroundView: UIView!
    @IBOutlet var view1: UIView!
    @IBOutlet var view2: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        cornerView.roundCorners(cornerRadius: 20, maskedCorners: [.layerMinXMinYCorner, .layerMaxXMinYCorner])
        // view 클릭 시, 함수 정의
        let tapGestureRecognizer1 = UITapGestureRecognizer(target: self, action: #selector(view1Tapped))
        view1.addGestureRecognizer(tapGestureRecognizer1)
        let tapGestureRecognizer2 = UITapGestureRecognizer(target: self, action: #selector(backgroundViewTapped))
        backgroundView.addGestureRecognizer(tapGestureRecognizer2)
        let tapGestureRecognizer3 = UITapGestureRecognizer(target: self, action: #selector(view2Tapped))
        view2.addGestureRecognizer(tapGestureRecognizer3)
    }
    @objc func view1Tapped(sender: UITapGestureRecognizer) {
        view1.backgroundColor = #colorLiteral(red: 0.9994661212, green: 0.979791224, blue: 0.9194086194, alpha: 1)
       //수정하기
    }
    @objc func view2Tapped(sender: UITapGestureRecognizer) {
        view2.backgroundColor = #colorLiteral(red: 0.9994661212, green: 0.979791224, blue: 0.9194086194, alpha: 1)
        goDeletePage()
    }
    @objc func backgroundViewTapped(sender: UITapGestureRecognizer) {
        modalDelegate?.modalDismiss()
        self.dismiss(animated: true, completion: nil)
    }
    func goDeletePage()  {
        //modalDelegate?.modalDismiss()
        if let vc = self.storyboard?.instantiateViewController(withIdentifier: "CommunityManagerNoticeAlertDeleteVC") as? CommunityManagerNoticeAlertDeleteVC {
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
