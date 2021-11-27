//
//  HomeManagerStoreListVC.swift
//  Albazip
//
//  Created by 김수빈 on 2021/11/27.
//

import Foundation
class HomeManagerStoreListVC: UIViewController{
    var isNoData = true
    var storeList: [HomeManagerStoreListData]?
    @IBOutlet var tableView: UITableView!
    
    // Datamanager
    lazy var dataManager: HomeManagerStoreListDatamanager = HomeManagerStoreListDatamanager()
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        showIndicator()
        dataManager.getHomeManagerStoreList(vc: self)
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

extension HomeManagerStoreListVC: UITableViewDataSource, UITableViewDelegate {
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
                    cell.delegate = self
                    if let x = data[indexPath.row].workerId{
                        // 근무자일때는 수정, 편집 버튼 비활성화
                        cell.btnDelete.isHidden = true
                        cell.btnEdit.isHidden = true
                    }else{
                        cell.btnDelete.isHidden = false
                        cell.btnEdit.isHidden = false
                        cell.managerId = data[indexPath.row].managerId!
                    }
                    
                    cell.storeNameLabel.text = data[indexPath.row].shop_name!
                    if data[indexPath.row].status! == 0{
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
extension HomeManagerStoreListVC {
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

extension HomeManagerStoreListVC: HomeManagerStoreListDelegate {
    func goEditPage(managerId:Int) {
       print("goEditPage")
        guard let nextVC = self.storyboard?.instantiateViewController(identifier: "HomeManagerEditStore1VC") as? HomeManagerEditStore1VC else {return}
        nextVC.managerId = managerId
        self.navigationController?.pushViewController(nextVC, animated: true)
        //HomeManagerEditStore1VC
    }
    
    func goDetailPage(managerId:Int) {
        print("goDetailPage")
    }
    
    
}
 
