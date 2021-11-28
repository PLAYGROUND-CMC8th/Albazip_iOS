//
//  CommunityWorkerNoticeDetailVC.swift
//  Albazip
//
//  Created by 김수빈 on 2021/11/24.
//

import Foundation
class CommunityWorkerNoticeDetailVC: UIViewController{
    var confirm = -1 // 0이면 미확인, 1이면 확인
    @IBOutlet var tableView: UITableView!
    var noticeId = -1
    var noticeData : CommunityManagerNoticeDetailData?
    // Datamanager
    lazy var dataManager: CommunityManagerNoticeDetailDatamanager = CommunityManagerNoticeDetailDatamanager()
    // Datamanager
    lazy var dataManager2: CommunityWorkerConfirmDatamanager = CommunityWorkerConfirmDatamanager()
    // CommunityWorkerNoticeDetailTableViewCell
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
           
            vc.delegate = self
        self.present(vc, animated: true, completion: nil)
    }
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
                    if boardInfo.image!.count == 1{
                        let url = URL(string: boardInfo.image![0].image_path!)
                        cell.image1.kf.setImage(with: url)
                        cell.image2.isHidden = true
                    }else if boardInfo.image!.count == 2{
                        let url = URL(string: boardInfo.image![0].image_path!)
                        cell.image1.kf.setImage(with: url)
                        let url2 = URL(string: boardInfo.image![1].image_path!)
                        cell.image2.kf.setImage(with: url2)
                    }else{
                        cell.image1.isHidden = true
                        cell.image2.isHidden = true
                        cell.height1.constant = 0
                        cell.height2.constant = 0
                    }
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
        
        if confirm == 0{// 미확인이면 확인 api 호출
            ////
            dataManager2.getCommunityWorkerNoticeDetail(noticeId: noticeId, vc: self)
        }else{
            dismissIndicator()
        }
    }
    
    func failedToRequestCommunityWorkerNoticeDetail(message: String) {
        dismissIndicator()
        presentAlert(title: message)
    }
}

extension CommunityWorkerNoticeDetailVC: CommunityWorkerNoticeAlertDetailDelegate, CommunityWorkerNoticeAlertDelegate{
    func successReport() {
        presentBottomAlert(message: "게시글이 신고되었습니다.")
    }
    
    func goReportModal() {
        if let vc = self.storyboard?.instantiateViewController(withIdentifier: "CommunityWorkerNoticeAlertDetailVC") as? CommunityWorkerNoticeAlertDetailVC {
            vc.modalPresentationStyle = .overFullScreen
            vc.delegate = self
            
            vc.noticeId = noticeId
            self.present(vc, animated: true, completion: nil)
    }
    
    
}
}
//공지사항 확인 api
extension CommunityWorkerNoticeDetailVC {
    func didSuccessCommunityWorkerConfirm(result: CommunityWorkerConfirmResponse) {
        
        print(result.message)
        dismissIndicator()
        
    }
    
    func failedToRequestCommunityWorkerConfirm(message: String) {
        dismissIndicator()
        presentAlert(title: message)
    }
}
