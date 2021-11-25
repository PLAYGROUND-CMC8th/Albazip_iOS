//
//  CommunityWorkerNoticeDetailVC.swift
//  Albazip
//
//  Created by 김수빈 on 2021/11/24.
//

import Foundation
class CommunityWorkerNoticeDetailVC: UIViewController{
    
    @IBOutlet var tableView: UITableView!
    var noticeId = -1
    @IBOutlet var modalBgView: UIView!
    var noticeData : CommunityManagerNoticeDetailData?
    // Datamanager
    lazy var dataManager: CommunityManagerNoticeDetailDatamanager = CommunityManagerNoticeDetailDatamanager()
    // CommunityWorkerNoticeDetailTableViewCell
    override func viewDidLoad() {
        super.viewDidLoad()
        modalBgView.isHidden = true
        setTableView()
        showIndicator()
        dataManager.getCommunityWorkerNoticeDetail(noticeId: noticeId, vc: self)
    }
    func setTableView(){
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: "CommunityWorkerNoticeDetailTableViewCell", bundle: nil),
                           forCellReuseIdentifier: "CommunityWorkerNoticeDetailTableViewCell")
    }
    @IBAction func btnCancel(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func btnSetting(_ sender: Any) {
        //설정 알림창
        if let vc = self.storyboard?.instantiateViewController(withIdentifier: "CommunityWorkerNoticeAlertVC") as? CommunityWorkerNoticeAlertVC {
            vc.modalPresentationStyle = .overFullScreen
            modalBgView.isHidden = false
            vc.modalDelegate = self
        self.present(vc, animated: true, completion: nil)
    }
    }
}
extension CommunityWorkerNoticeDetailVC: ModalDelegate{
    func modalDismiss() {
        modalBgView.isHidden = true
        print("모달 종료")
    }
    
    func textFieldData(data: String) {
        print(data)
    }
    
    
}
// 테이블뷰 extension
extension CommunityWorkerNoticeDetailVC: UITableViewDataSource, UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //print(String(lists.count) + " 줄")
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "CommunityWorkerNoticeDetailTableViewCell") as? CommunityWorkerNoticeDetailTableViewCell {
            cell.selectionStyle = .none
            if let data = noticeData{
                if let writerInfo = data.writerInfo{
                    cell.nameLabel.text = writerInfo.name!
                    cell.positionLabel.text = writerInfo.title!
                    /*
                    cell.profileImage.image = writerInfo.name!*/
                    if let img = writerInfo.image{
                        let url = URL(string: img)
                        cell.profileImage.kf.setImage(with: url)
                    }
                }
                if let boardInfo = data.boardInfo{
                    cell.titleLabel.text = boardInfo.title!
                    cell.detailLabel.text = boardInfo.content!
                    cell.dateLabel.text = boardInfo.registerDate!.insertDate
                }
                if let confirmInfo = data.writerInfo{
                    
                }
                
            }
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("선택된 행은 \(indexPath.row) 입니다.")
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.estimatedRowHeight
    }
}
extension CommunityWorkerNoticeDetailVC {
    func didSuccessCommunityWorkerNoticeDetail(result: CommunityManagerNoticeDetailResponse) {
        
        noticeData = result.data
        print(noticeData)
        tableView.reloadData()
        dismissIndicator()
    }
    
    func failedToRequestCommunityWorkerNoticeDetail(message: String) {
        dismissIndicator()
        presentAlert(title: message)
    }
}
