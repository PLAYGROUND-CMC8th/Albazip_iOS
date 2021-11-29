//
//  CommunityManagerNoticeDetailVC.swift
//  Albazip
//
//  Created by 김수빈 on 2021/11/24.
//

import Foundation
class CommunityManagerNoticeDetailVC: UIViewController{
    //var confirm = -1 // 0이면 미확인, 1이면 확인
    var noticeId = -1
    var imageArray = [UIImage]()
    @IBOutlet var tableView: UITableView!
    @IBOutlet var modalBgView: UIView!
    var noticeData : CommunityManagerNoticeDetailData?
    // Datamanager
    lazy var dataManager: CommunityManagerNoticeDetailDatamanager = CommunityManagerNoticeDetailDatamanager()
    override func viewDidLoad() {
        super.viewDidLoad()
        modalBgView.isHidden = true
        setTableView()
        /*
        showIndicator()
        dataManager.getCommunityManagerNoticeDetail(noticeId: noticeId, vc: self)*/
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(false)
        showIndicator()
        dataManager.getCommunityManagerNoticeDetail(noticeId: noticeId, vc: self)
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
        if let vc = self.storyboard?.instantiateViewController(withIdentifier: "CommunityManagerNoticeAlertVC") as? CommunityManagerNoticeAlertVC {
            vc.modalPresentationStyle = .overFullScreen
            modalBgView.isHidden = false
            vc.modalDelegate = self
            vc.delegate = self
        self.present(vc, animated: true, completion: nil)
    }
    }
}
extension CommunityManagerNoticeDetailVC: ModalDelegate{
    func modalDismiss() {
        modalBgView.isHidden = true
        print("모달 종료")
    }
    
    func textFieldData(data: String) {
        print(data)
    }
    
    
}
// 테이블뷰 extension
extension CommunityManagerNoticeDetailVC: UITableViewDataSource, UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //print(String(lists.count) + " 줄")
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "CommunityWorkerNoticeDetailTableViewCell") as? CommunityWorkerNoticeDetailTableViewCell {
            cell.delegate = self
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
                        cell.image1.isHidden = false
                        let url = URL(string: boardInfo.image![0].image_path!)
                        cell.image1.kf.setImage(with: url)
                        
                        
                        cell.image2.isHidden = true
                        cell.height1.constant = 48
                        cell.height2.constant = 120
                    }else if boardInfo.image!.count == 2{
                        cell.image1.isHidden = false
                        cell.image2.isHidden = false
                        let url = URL(string: boardInfo.image![0].image_path!)
                        cell.image1.kf.setImage(with: url)
                        let url2 = URL(string: boardInfo.image![1].image_path!)
                        cell.image2.kf.setImage(with: url2)
                        cell.height1.constant = 48
                        cell.height2.constant = 120
                        
                    }else{
                        cell.image1.isHidden = true
                        cell.image2.isHidden = true
                        cell.height1.constant = 0
                        cell.height2.constant = 0
                    }
                }
                if let confirmInfo = data.confirmInfo{
                    cell.setCell(data: confirmInfo.confirmer!)
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
extension CommunityManagerNoticeDetailVC {
    func didSuccessCommunityManagerNoticeDetail(result: CommunityManagerNoticeDetailResponse) {
        
        noticeData = result.data
        print(noticeData)
        tableView.reloadData()
        dismissIndicator()
        
       
    }
    
    func failedToRequestCommunityManagerNoticeDetail(message: String) {
        dismissIndicator()
        presentAlert(title: message)
    }
    
}

extension CommunityManagerNoticeDetailVC: CommunityManagerNoticeAlertVCDelegate, CommunityManagerNoticeAlertDeleteDelegate{
    func goDeleteModal() {
        if let vc = self.storyboard?.instantiateViewController(withIdentifier: "CommunityManagerNoticeAlertDeleteVC") as? CommunityManagerNoticeAlertDeleteVC {
            vc.modalPresentationStyle = .overFullScreen
            vc.delegate = self
            vc.noticeId = noticeId
            self.present(vc, animated: true, completion: nil)
        }
    }
    func goEditPage(){
        //수정하기 페이지로
        imageArray.removeAll()
        print("수정하기 페이지로")
        guard let nextVC = self.storyboard?.instantiateViewController(identifier: "CommunityMangerNoticeEditVC") as? CommunityMangerNoticeEditVC else {return}
        nextVC.noticeId = noticeId
        if let data = noticeData{
            if let board = data.boardInfo{
                nextVC.titleText = board.title!
                nextVC.contentText = board.content!
                var i = 0
                while i < board.image!.count{
                    let image = UIImageView()
                    let url = URL(string: board.image![i].image_path!)
                    image.kf.setImage(with: url)
                    imageArray.append(image.image!)
                    i += 1
                }
                nextVC.imageArray = imageArray
                
            }
        }
        
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
    
    //공지사항 삭제 성공하면 이전 페이지로
    func successDeleteNotice() {
        self.navigationController?.popViewController(animated: true)
    }
}


extension CommunityManagerNoticeDetailVC: CommunityWorkerNoticeDetailDelegate{
    func showImagePage(index: Int) {
        if let vc = self.storyboard?.instantiateViewController(withIdentifier: "CommunityManagerNoticeDetailImageVC") as? CommunityManagerNoticeDetailImageVC {
            vc.modalPresentationStyle = .overFullScreen
            if let data = noticeData{
                if let board = data.boardInfo{
                    //let url = URL(string: board.image![index].image_path!)
                    vc.imageUrl = board.image![index].image_path!
                }
            }
            
            self.present(vc, animated: false, completion: nil)
            
        }
    }
    
    
}
