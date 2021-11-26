//
//  CommunityManagerNoticeVC.swift
//  Albazip
//
//  Created by 김수빈 on 2021/11/24.
//
import XLPagerTabStrip
import Foundation

class CommunityManagerNoticeVC: UIViewController, IndicatorInfoProvider {
    var noticeList : [CommunityManagerNoticeData]?
    var isNoData = true
    // Datamanager
    lazy var dataManager: CommunityManagerNoticeDatamanger = CommunityManagerNoticeDatamanger()
    // Datamanager
    lazy var dataManager2: CommunityManagerNoticePinDatamanager = CommunityManagerNoticePinDatamanager()
    @IBOutlet var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        setTableView()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(false)
        print("viewWillAppear1")
        showIndicator()
        dataManager.getCommunityManagerNotice(vc: self)
        
    }
    func setTableView(){
        let header = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 18))
        header.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        tableView.tableHeaderView = header
        tableView.register(UINib(nibName: "CommunityManagerNoticeTableViewCell", bundle: nil),
                           forCellReuseIdentifier: "CommunityManagerNoticeTableViewCell")
        //417
  
        tableView.register(UINib(nibName: "CommunityManagerNoNoticeTableViewCell", bundle: nil),
                           forCellReuseIdentifier: "CommunityManagerNoNoticeTableViewCell")
        tableView.dataSource = self
        tableView.delegate = self
    }
//CommunityWorkerNoticeTableViewCell
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: "공지사항")
      }
}
// 테이블뷰 extension
extension CommunityManagerNoticeVC: UITableViewDataSource, UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //print(String(lists.count) + " 줄")
        if isNoData{
            return 1
        }else{
            if let data = noticeList{
                return data.count
            }
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if isNoData{
            if let cell = tableView.dequeueReusableCell(withIdentifier: "CommunityManagerNoNoticeTableViewCell") as? CommunityManagerNoNoticeTableViewCell {
                cell.selectionStyle = .none
                
                return cell
            }
        }else{
            if let cell = tableView.dequeueReusableCell(withIdentifier: "CommunityManagerNoticeTableViewCell") as? CommunityManagerNoticeTableViewCell {
                cell.selectionStyle = .none
                if let data = noticeList{
                    //cell.checkLabel.isHidden = true
                    cell.titleLabel.text = data[indexPath.row].title!
                    cell.subLabel.text = data[indexPath.row].registerDate!.insertDate
                    if data[indexPath.row].pin! == 0{
                        cell.btnPin.setImage(#imageLiteral(resourceName: "icPushpinInactive"), for: .normal)
                    }else{
                        cell.btnPin.setImage(#imageLiteral(resourceName: "icPushpinActive"), for: .normal)
                    }
                    
                }
                return cell
            }
        }
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("선택된 행은 \(indexPath.row) 입니다.")
        
        if !isNoData{
            guard let nextVC = self.storyboard?.instantiateViewController(identifier: "CommunityManagerNoticeDetailVC") as? CommunityManagerNoticeDetailVC else {return}
            nextVC.noticeId = noticeList![indexPath.row].id!
            self.navigationController?.pushViewController(nextVC, animated: true)
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.estimatedRowHeight
    }
}
extension CommunityManagerNoticeVC {
    func didSuccessCommunityManagerNotice(result: CommunityManagerNoticeResponse) {
        
        
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
    
    func failedToRequestCommunityManagerNotice(message: String) {
        dismissIndicator()
        presentAlert(title: message)
    }
    //공지사항 핀 aPI
    func didSuccessCommunityManagerNoticePin(result: CommunityManagerNoticePinResponse) {
        
        tableView.reloadData()
        dismissIndicator()
    }
    
    func failedToRequestCommunityManagerNoticePin(message: String) {
        dismissIndicator()
        presentAlert(title: message)
    }
}

