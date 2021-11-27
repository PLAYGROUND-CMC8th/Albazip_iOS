//
//  HomeWorkerStoreListVC.swift
//  Albazip
//
//  Created by 김수빈 on 2021/11/27.
//

import Foundation
class HomeWorkerStoreListVC: UIViewController{
    var isNoData = true
    var storeList: [HomeManagerStoreListData]?
    // Datamanager
    lazy var dataManager: HomeManagerStoreListDatamanager = HomeManagerStoreListDatamanager()
    @IBOutlet var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        showIndicator()
        dataManager.getHomeWorkerStoreList(vc: self)
    }
    @IBAction func btnCancel(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func btnAddStore(_ sender: Any) {
        presentBottomAlert(message: "다음 업데이트에서 추가될 기능입니다:)")
    }
    func setupTableView() {
        
        tableView.register(UINib(nibName: "HomeManagerStoreListTableViewCell", bundle: nil),
                           forCellReuseIdentifier: "HomeManagerStoreListTableViewCell")
        //작성 글 없을 때
        tableView.register(UINib(nibName: "MyPageManagerNoWriteTableViewCell", bundle: nil),
                           forCellReuseIdentifier: "MyPageManagerNoWriteTableViewCell")
        tableView.dataSource = self
        tableView.delegate = self
      
    }
}

//MARK:- Table View Data Source

extension HomeWorkerStoreListVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if isNoData{
            if let cell = tableView.dequeueReusableCell(withIdentifier: "MyPageManagerNoWriteTableViewCell") as? MyPageManagerNoWriteTableViewCell {
                cell.selectionStyle = .none
                cell.bgView.backgroundColor = .none
                cell.titleLabel.text = "매장이 없어요."
                   print(indexPath.row)
               return cell
            }
        }else{
            if let cell = tableView.dequeueReusableCell(withIdentifier: "HomeManagerStoreListTableViewCell") as? HomeManagerStoreListTableViewCell {
                    
                cell.selectionStyle = .none
                if let data = storeList{
                   
                    cell.btnEdit.isHidden = true
                    cell.btnDelete.isHidden = true
                    cell.storeNameLabel.text = data[indexPath.row].shop_name!
                    if data[indexPath.row].status! == 1{
                        cell.mainView.backgroundColor = #colorLiteral(red: 0.9994661212, green: 0.979791224, blue: 0.9194086194, alpha: 1)
                        cell.storeNameLabel.textColor = #colorLiteral(red: 0.2038974464, green: 0.2039384246, blue: 0.2038920522, alpha: 1)
                    }
                }
                
                print(indexPath.row)
                return cell
            }
        }
       
        
        return UITableViewCell()
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let data = storeList{
            return data.count
        }else{
            return 0
        }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 72
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("선택된 행은 \(indexPath.row) 입니다.")
        
    }
    
}
}

extension HomeWorkerStoreListVC {
    func didSuccessHomeManagerStoreList(result: HomeManagerStoreListResponse) {
        storeList = result.data
        print(storeList)
        
        if storeList!.count != 0 {
            isNoData = false
        }else{
            isNoData = true
        }
        
        tableView.reloadData()
        dismissIndicator()
    }
    
    func failedToRequestHomeManagerStoreList(message: String) {
        dismissIndicator()
        presentAlert(title: message)
    }
}
