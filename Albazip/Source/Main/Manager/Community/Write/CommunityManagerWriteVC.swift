//
//  CommunityManagerWriteVC.swift
//  Albazip
//
//  Created by 김수빈 on 2021/11/25.
//

import Foundation
class CommunityManagerWriteVC: UIViewController{
    
    @IBOutlet var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        setTableView()
    }
    @IBAction func btnCancel(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    func setTableView(){
        
        tableView.register(UINib(nibName: "CommunityManagerWriteTableViewCell", bundle: nil),
                           forCellReuseIdentifier: "CommunityManagerWriteTableViewCell")
        tableView.register(UINib(nibName: "CommunityManagerPhotoTableViewCell", bundle: nil),
                           forCellReuseIdentifier: "CommunityManagerPhotoTableViewCell")
        tableView.dataSource = self
        tableView.delegate = self
    }
    @IBAction func btnNext(_ sender: Any) {
    }
}
// 테이블뷰 extension
extension CommunityManagerWriteVC: UITableViewDataSource, UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //print(String(lists.count) + " 줄")
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 0{
            if let cell = tableView.dequeueReusableCell(withIdentifier: "CommunityManagerWriteTableViewCell") as? CommunityManagerWriteTableViewCell {
                cell.selectionStyle = .none
                return cell
            }
        }else{
            if let cell = tableView.dequeueReusableCell(withIdentifier: "CommunityManagerPhotoTableViewCell") as? CommunityManagerPhotoTableViewCell {
                cell.selectionStyle = .none
                return cell
            }
        }
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("선택된 행은 \(indexPath.row) 입니다.")
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0{
            return 375
        }else{
            return 176
        }
        //return tableView.estimatedRowHeight
    }
}
