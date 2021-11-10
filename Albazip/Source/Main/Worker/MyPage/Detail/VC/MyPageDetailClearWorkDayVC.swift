//
//  MyPageDetailClearWorkDayVC.swift
//  Albazip
//
//  Created by 김수빈 on 2021/11/11.
//

import Foundation
class MyPageDetailClearWorkDayVC: UIViewController{
    
    @IBOutlet var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
    }
    //MARK:- View Setup
    @IBAction func btnCancel(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    func setupTableView() {
        
//MyPageDetailClearWorkNoCompleteTableViewCell
        //미완료 82
        tableView.register(UINib(nibName: "MyPageDetailNoClearWorkTableViewCell", bundle: nil),
                           forCellReuseIdentifier: "MyPageDetailNoClearWorkTableViewCell")
        //완료 82
        tableView.register(UINib(nibName: "MyPageDetailPublicWorkTableViewCell", bundle: nil),
                           forCellReuseIdentifier: "MyPageDetailPublicWorkTableViewCell")
        //미완료, 완료 헤더 50
        tableView.register(UINib(nibName: "MyPageDetailClearWorkNoCompleteTableViewCell", bundle: nil),
                           forCellReuseIdentifier: "MyPageDetailClearWorkNoCompleteTableViewCell")
        //모두 완료: 100
        tableView.register(UINib(nibName: "MyPageDetailAllClearWorkTableViewCell", bundle: nil),
                           forCellReuseIdentifier: "MyPageDetailAllClearWorkTableViewCell")
        
        //미완료, 완료 중간 구분자 43
        tableView.register(UINib(nibName: "MyPageDetailClearWorkMiddleTableViewCell", bundle: nil),
                           forCellReuseIdentifier: "MyPageDetailClearWorkMiddleTableViewCell")
        tableView.dataSource = self
        tableView.delegate = self
    }
}
extension MyPageDetailClearWorkDayVC: UITableViewDataSource,UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 0{
            if let cell = tableView.dequeueReusableCell(withIdentifier: "MyPageDetailClearWorkNoCompleteTableViewCell") as? MyPageDetailClearWorkNoCompleteTableViewCell {
                cell.selectionStyle = .none
                print(indexPath.row)
                return cell
            }
        }else if indexPath.row == 1{
            if let cell = tableView.dequeueReusableCell(withIdentifier: "MyPageDetailNoClearWorkTableViewCell") as? MyPageDetailNoClearWorkTableViewCell {
                cell.selectionStyle = .none
                print(indexPath.row)
                return cell
            }
        }else if indexPath.row == 2{
            if let cell = tableView.dequeueReusableCell(withIdentifier: "MyPageDetailClearWorkMiddleTableViewCell") as? MyPageDetailClearWorkMiddleTableViewCell {
                cell.selectionStyle = .none
                print(indexPath.row)
                return cell
            }
        }else if indexPath.row == 3{
            if let cell = tableView.dequeueReusableCell(withIdentifier: "MyPageDetailClearWorkNoCompleteTableViewCell") as? MyPageDetailClearWorkNoCompleteTableViewCell{
                cell.selectionStyle = .none
                cell.titleLabel.text = "완료"
                print(indexPath.row)
                return cell
            }
        }else{
            if let cell = tableView.dequeueReusableCell(withIdentifier: "MyPageDetailPublicWorkTableViewCell") as? MyPageDetailPublicWorkTableViewCell {
                cell.selectionStyle = .none
                print(indexPath.row)
                return cell
            }
            
        }
        
        return UITableViewCell()
    }
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat{
        /*
        if indexPath.row == 0{
            return 113
        }else
        */
        if indexPath.row == 0{
            return 50
        }else if indexPath.row == 1{
            return 82
        }else if indexPath.row == 2{
            return 43
        }else if indexPath.row == 3{
            return 50
        }else {
            return 82
        }
       
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        print("선택된 행은 \(indexPath.row) 입니다.")
    }
    
}
