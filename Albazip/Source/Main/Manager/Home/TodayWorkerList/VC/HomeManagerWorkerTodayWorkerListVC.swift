//
//  HomeWorkerTodayWorkerListVC.swift
//  Albazip
//
//  Created by 김수빈 on 2021/11/13.
//

import Foundation
class HomeManagerWorkerTodayWorkerListVC: UIViewController{
    var todayWorkerList: [TodayWorkerListData]?
    var isNoData = true
    // Datamanager
    lazy var dataManager: TodayWorkerListDatamanager = TodayWorkerListDatamanager()
    @IBOutlet var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        showIndicator()
        dataManager.getTodayWorkerList(vc: self)
    }
    @IBAction func btnCancel(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    func setupTableView() {
        
        tableView.register(UINib(nibName: "TodayWorkerListTableViewCell", bundle: nil),
                           forCellReuseIdentifier: "TodayWorkerListTableViewCell")
        //작성 글 없을 때
        tableView.register(UINib(nibName: "MyPageManagerNoWriteTableViewCell", bundle: nil),
                           forCellReuseIdentifier: "MyPageManagerNoWriteTableViewCell")
        tableView.dataSource = self
        tableView.delegate = self
        tableView.tableFooterView = UIView()

        
      
    }
}
//MARK:- Table View Data Source

extension HomeManagerWorkerTodayWorkerListVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if isNoData{
            if let cell = tableView.dequeueReusableCell(withIdentifier: "MyPageManagerNoWriteTableViewCell") as? MyPageManagerNoWriteTableViewCell {
                cell.selectionStyle = .none
                cell.bgView.backgroundColor = .none
                cell.titleLabel.text = "오늘은 근무자가 없어요."
                   print(indexPath.row)
               return cell
            }
        }else{
            if let cell = tableView.dequeueReusableCell(withIdentifier: "TodayWorkerListTableViewCell") as? TodayWorkerListTableViewCell {
                    
                cell.selectionStyle = .none
                if let data = todayWorkerList{
                    if data[indexPath.row].workerImage != nil{
                        let url = URL(string: data[indexPath.row].workerImage!)
                        cell.profileImage.kf.setImage(with: url)

                    }else{
                        cell.profileImage.image =  #imageLiteral(resourceName: "imgProfile84Px1")
                    }
                    cell.positionLabel.text = data[indexPath.row].workerTitle!
                    cell.nameLabel.text = data[indexPath.row].workerName!
                }
                
                print(indexPath.row)
                return cell
            }
        }
       
        
        return UITableViewCell()
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let data = todayWorkerList{
            return data.count
        }else{
            return 0
        }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 80
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("선택된 행은 \(indexPath.row) 입니다.")
        
    }
    
}
}
extension HomeManagerWorkerTodayWorkerListVC {
    func didSuccessTodayWorkerList(result: TodayWorkerListResponse) {
        todayWorkerList = result.data
        print(todayWorkerList)
        
        if todayWorkerList!.count != 0 {
            isNoData = false
        }else{
            isNoData = true
        }
        
        tableView.reloadData()
        dismissIndicator()
    }
    
    func failedToRequestTodayWorkerList(message: String) {
        dismissIndicator()
        presentAlert(title: message)
    }
}
