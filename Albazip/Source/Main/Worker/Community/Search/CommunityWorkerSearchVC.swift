//
//  CommunityWorkerSearchVC.swift
//  Albazip
//
//  Created by 김수빈 on 2021/11/24.
//

import Foundation
class CommunityWorkerSearchVC: UIViewController{
    @IBOutlet var tableView: UITableView!
    @IBOutlet var searchTextField: UITextField!
    var isNoData = true
    var noticeList : [CommunitySearchData]?
    // Datamanager
    lazy var dataManager: CommunityWorkerSearchDatamanager = CommunityWorkerSearchDatamanager()
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        setTableView()
    }
    func setUI()  {
        searchTextField.addLeftPadding2()
    }
    @IBAction func btnCancel(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    func setTableView(){
        let header = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 18))
        header.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        tableView.tableHeaderView = header
        tableView.register(UINib(nibName: "CommunityWorkerNoticeTableViewCell", bundle: nil),
                           forCellReuseIdentifier: "CommunityWorkerNoticeTableViewCell")
        tableView.register(UINib(nibName: "CommunitySearchNoDataTableViewCell", bundle: nil),
                           forCellReuseIdentifier: "CommunitySearchNoDataTableViewCell")
        //CommunitySearchNoDataTableViewCell
        tableView.dataSource = self
        tableView.delegate = self
    }
}
// 테이블뷰 extension
extension CommunityWorkerSearchVC: UITableViewDataSource, UITableViewDelegate{
    
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
            if let cell = tableView.dequeueReusableCell(withIdentifier: "CommunityWorkerNoticeTableViewCell") as? CommunityWorkerNoticeTableViewCell {
                cell.selectionStyle = .none
                return cell
            }
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("선택된 행은 \(indexPath.row) 입니다.")
        if !isNoData{
            guard let nextVC = self.storyboard?.instantiateViewController(identifier: "CommunityWorkerNoticeDetailVC") as? CommunityWorkerNoticeDetailVC else {return}
            self.navigationController?.pushViewController(nextVC, animated: true)
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.estimatedRowHeight
    }
}
extension CommunityWorkerSearchVC {
    func didSuccessCommunityWorkerSearch(result: CommunitySearchResponse) {
        
        
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
    
    func failedToRequestCommunityWorkerSearch(message: String) {
        dismissIndicator()
        presentAlert(title: message)
    }
}
