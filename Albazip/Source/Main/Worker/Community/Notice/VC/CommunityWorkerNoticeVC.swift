//
//  CommunityWorkerNoticeVC.swift
//  Albazip
//
//  Created by 김수빈 on 2021/11/23.
//

import UIKit
import XLPagerTabStrip

class CommunityWorkerNoticeVC: UIViewController,IndicatorInfoProvider {
    var isNoData = true
    var noticeList : [CommunityManagerNoticeData]?
    @IBOutlet var tableView: UITableView!
    // Datamanager
    lazy var dataManager: CommunityManagerNoticeDatamanger = CommunityManagerNoticeDatamanger()
    override func viewDidLoad() {
        super.viewDidLoad()
        setTableView()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(false)
        print("viewWillAppear1")
        showIndicator()
        dataManager.getCommunityWorkerNotice(vc: self)
        
    }
    func setTableView(){
        let header = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 18))
        header.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        tableView.tableHeaderView = header
        tableView.register(UINib(nibName: "CommunityWorkerNoticeTableViewCell", bundle: nil),
                           forCellReuseIdentifier: "CommunityWorkerNoticeTableViewCell")
        
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
extension CommunityWorkerNoticeVC: UITableViewDataSource, UITableViewDelegate{
    
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
                cell.btnAddNotice.isHidden = true
                return cell
            }
        }else{
            if let cell = tableView.dequeueReusableCell(withIdentifier: "CommunityWorkerNoticeTableViewCell") as? CommunityWorkerNoticeTableViewCell {
                cell.selectionStyle = .none
                if let data = noticeList{
                    //cell.checkLabel.isHidden = true
                    if data[indexPath.row].confirm! == 0{
                        cell.checkLabel.text = "미확인"
                        cell.checkLabel.textColor = #colorLiteral(red: 0.9833402038, green: 0.2258323133, blue: 0, alpha: 1)
                        cell.checkLabel.backgroundColor = #colorLiteral(red: 1, green: 0.8983411193, blue: 0.8958156705, alpha: 1)
                        cell.noticeView.backgroundColor =  #colorLiteral(red: 0.9994661212, green: 0.979791224, blue: 0.9194086194, alpha: 1)
                        cell.noticeView.borderColor =  #colorLiteral(red: 0.9983271956, green: 0.9391896129, blue: 0.7384549379, alpha: 1)
                    }else{
                        cell.checkLabel.text = "확인"
                        cell.checkLabel.textColor = #colorLiteral(red: 0.1636831164, green: 0.7599473596, blue: 0.3486425281, alpha: 1)
                        cell.checkLabel.backgroundColor = #colorLiteral(red: 0.8957179189, green: 0.9912716746, blue: 0.9204327464, alpha: 1)
                        cell.noticeView.backgroundColor =  .none
                        cell.noticeView.borderColor =  #colorLiteral(red: 0.9293201566, green: 0.9294758439, blue: 0.9292996526, alpha: 1)
                    }
                    cell.titleLabel.text = data[indexPath.row].title!
                    cell.subLabel.text = data[indexPath.row].registerDate!.insertDate
                    if data[indexPath.row].pin! == 0{
                        cell.pinImage.isHidden = true
                    }else{
                        cell.pinImage.isHidden = false
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
            guard let nextVC = self.storyboard?.instantiateViewController(identifier: "CommunityWorkerNoticeDetailVC") as? CommunityWorkerNoticeDetailVC else {return}
            nextVC.noticeId = noticeList![indexPath.row].id!
            nextVC.confirm = noticeList![indexPath.row].confirm!
            self.navigationController?.pushViewController(nextVC, animated: true)
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.estimatedRowHeight
    }
}
extension CommunityWorkerNoticeVC {
    func didSuccessCommunityWorkerNotice(result: CommunityManagerNoticeResponse) {
        
        
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
    
    func failedToRequestCommunityWorkerNotice(message: String) {
        dismissIndicator()
        presentAlert(title: message)
    }
}

