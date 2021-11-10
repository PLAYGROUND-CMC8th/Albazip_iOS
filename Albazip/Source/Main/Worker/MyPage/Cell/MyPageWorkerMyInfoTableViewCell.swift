//
//  MyPageWorkerMyInfoTableViewCell.swift
//  Albazip
//
//  Created by 김수빈 on 2021/11/03.
//

import UIKit

protocol MyPageWorkerMyInfoDelegate {
    func goCommuteRecordVC()
    func goPublicWorkVC()
    func goClearWorkVC()
    func goLeaveWorkVC()
    
}

class MyPageWorkerMyInfoTableViewCell: UITableViewCell {

    @IBOutlet var lateCountView: UIView!
    @IBOutlet var joinPublicView: UIView!
    @IBOutlet var clearRateView: UIView!
    var delegate: MyPageWorkerMyInfoDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setView()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setView()  {
        // view 클릭 시, 함수 정의
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(lateCountViewTapped))
        lateCountView.addGestureRecognizer(tapGestureRecognizer)
        
        let tapGestureRecognizer2 = UITapGestureRecognizer(target: self, action: #selector(joinPublicViewTapped))
        joinPublicView.addGestureRecognizer(tapGestureRecognizer2)
        
        let tapGestureRecognizer3 = UITapGestureRecognizer(target: self, action: #selector(clearRateViewTapped))
        clearRateView.addGestureRecognizer(tapGestureRecognizer3)
        
    }
    @objc func lateCountViewTapped(sender: UITapGestureRecognizer) {
        print("지각횟수")
        self.delegate?.goCommuteRecordVC()
    }
    @objc func joinPublicViewTapped(sender: UITapGestureRecognizer) {
        print("공동업무 참여 횟수")
        self.delegate?.goPublicWorkVC()
    }
    @objc func clearRateViewTapped(sender: UITapGestureRecognizer) {
        print("업무완수율")
        self.delegate?.goClearWorkVC()
    }
    @IBAction func btnLeaveWork(_ sender: Any) {
        print("퇴사하기")
        self.delegate?.goLeaveWorkVC()
    }
    
    
}
