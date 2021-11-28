//
//  CommunityManagerSearchVC.swift
//  Albazip
//
//  Created by 김수빈 on 2021/11/24.
//

import Foundation
class CommunityManagerSearchVC: UIViewController{
    var isNoData = true
    @IBOutlet var textField: UITextField!
    @IBOutlet var tableView: UITableView!
    var noticeList : [CommunitySearchData]?
    // Datamanager
    lazy var dataManager: CommunityWorkerSearchDatamanager = CommunityWorkerSearchDatamanager()
    override func viewDidLoad() {
        super.viewDidLoad()
        textField.addLeftPadding2()
        setTableView()
    }
    func setTableView(){
        let header = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 18))
        header.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        tableView.tableHeaderView = header
        tableView.register(UINib(nibName: "CommunityManagerNoticeTableViewCell", bundle: nil),
                           forCellReuseIdentifier: "CommunityManagerNoticeTableViewCell")
        tableView.register(UINib(nibName: "CommunitySearchNoDataTableViewCell", bundle: nil),
                           forCellReuseIdentifier: "CommunitySearchNoDataTableViewCell")
        tableView.dataSource = self
        tableView.delegate = self
    }
    @IBAction func btnCancel(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}
// 테이블뷰 extension
extension CommunityManagerSearchVC: UITableViewDataSource, UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //print(String(lists.count) + " 줄")
        if isNoData{
            return 1
        }else{
            if let data = noticeList{
                return data.count
            }
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if isNoData{
            if let cell = tableView.dequeueReusableCell(withIdentifier: "CommunitySearchNoDataTableViewCell") as? CommunitySearchNoDataTableViewCell {
                cell.selectionStyle = .none
                return cell
            }
        }else{
            if let cell = tableView.dequeueReusableCell(withIdentifier: "CommunityManagerNoticeTableViewCell") as? CommunityManagerNoticeTableViewCell {
                cell.selectionStyle = .none
                return cell
            }
        }
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("선택된 행은 \(indexPath.row) 입니다.")
        if !isNoData{
            guard let nextVC = self.storyboard?.instantiateViewController(identifier: "CommunityManagerNoticeDetailVC") as? CommunityManagerNoticeDetailVC else {return}
            self.navigationController?.pushViewController(nextVC, animated: true)
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.estimatedRowHeight
    }
}
extension CommunityManagerSearchVC {
    func didSuccessCommunityManagerSearch(result: CommunitySearchResponse) {
        
        
        noticeList = result.data
        print("noticeList: \(noticeList)")
        if  noticeList!.count != 0{
            isNoData = false
        }else{
            isNoData = true
        }
        tableView.reloadData()
        dismissIndicator()
    }
    
    func failedToRequestCommunityManagerSearch(message: String) {
        dismissIndicator()
        presentAlert(title: message)
    }
}
