//
//  CommunityWorkerNoticeDetailVC.swift
//  Albazip
//
//  Created by 김수빈 on 2021/11/24.
//

import Foundation
class CommunityWorkerNoticeDetailVC: UIViewController{
    
    @IBOutlet var tableView: UITableView!
    
    @IBOutlet var modalBgView: UIView!
    // CommunityWorkerNoticeDetailTableViewCell
    override func viewDidLoad() {
        super.viewDidLoad()
        modalBgView.isHidden = true
        setTableView()
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
            cell.detailLabel.text = "출입자명부 작성 철저하게 해주세요!\n 주문 받은 뒤, 홀 손님에겐 꼭 명부작성 권유 해야합니다.\n테이크아웃 손님은 매장에 들어와서 주문시에 권유 해주세요!\n"
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
