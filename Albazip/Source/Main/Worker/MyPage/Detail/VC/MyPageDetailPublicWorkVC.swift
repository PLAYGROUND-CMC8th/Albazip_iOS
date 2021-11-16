//
//  MyPageDetailPublicWorkVC.swift
//  Albazip
//
//  Created by 김수빈 on 2021/11/03.
//

import Foundation
import UIKit

class MyPageDetailPublicWorkVC: UIViewController{
    var positionId = -1 // 근무자이면 디폴트값 -1
    @IBOutlet var countLabel: UILabel!
    var isNoData = true
    lazy var dataManager: MyPageDetailPublicWorkDataManager = MyPageDetailPublicWorkDataManager()
    //
    var data: [MyPageDetailPublicWorkData]?
    @IBOutlet var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        showIndicator()
        dataManager.getMyPageDetailPublicWork(vc: self, positionId: positionId)
    }
    @IBAction func btnCancel(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    //MARK:- View Setup
    
    func setupTableView() {
        
        //tableView.register(UINib(nibName: "MyPageDetailCountTableViewCell", bundle: nil),forCellReuseIdentifier: "MyPageDetailCountTableViewCell")
        tableView.register(UINib(nibName: "MyPageDetailPublicWorkTableViewCell", bundle: nil),forCellReuseIdentifier: "MyPageDetailPublicWorkTableViewCell")
        tableView.register(UINib(nibName: "MyPageDetailPublicDateTableViewCell", bundle: nil),
                           forCellReuseIdentifier: "MyPageDetailPublicDateTableViewCell")
        //작성 글 없을 때
        tableView.register(UINib(nibName: "MyPageManagerNoWriteTableViewCell", bundle: nil),
                           forCellReuseIdentifier: "MyPageManagerNoWriteTableViewCell")
        tableView.dataSource = self
        tableView.delegate = self
    }
}
//MARK:- Table View Data Source

extension MyPageDetailPublicWorkVC: UITableViewDataSource,UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isNoData{
            return 1
        }else{
            if let x = data{
                return x.count * 2
            }
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        /*
        if indexPath.row == 0{
            if let cell = tableView.dequeueReusableCell(withIdentifier: "MyPageDetailCountTableViewCell") as? MyPageDetailCountTableViewCell {
                cell.selectionStyle = .none
                cell.titleLabel.text = "공동업무 참여횟수"
                cell.countLabel.text = "3"
                cell.unitLabel.text = "회"
                print(indexPath.row)
                return cell
            }
        }else*/
        if isNoData{
            if let cell = tableView.dequeueReusableCell(withIdentifier: "MyPageManagerNoWriteTableViewCell") as? MyPageManagerNoWriteTableViewCell {
                cell.selectionStyle = .none
                cell.bgView.backgroundColor = .none
                cell.titleLabel.text = "완료한 공동업무가 없어요."
                   print(indexPath.row)
               return cell
            }
        }else{
            if indexPath.row % 2 == 0{
                if let cell = tableView.dequeueReusableCell(withIdentifier: "MyPageDetailPublicDateTableViewCell") as? MyPageDetailPublicDateTableViewCell {
                    cell.selectionStyle = .none
                    print(indexPath.row)
                    if let x = data{
                        cell.titleLabel.text = " \(x[indexPath.row / 2].year!).\(x[indexPath.row / 2].month!).\(x[indexPath.row / 2].date!)"
                    }
                    return cell
                }
            }else{
                if let cell = tableView.dequeueReusableCell(withIdentifier: "MyPageDetailPublicWorkTableViewCell") as? MyPageDetailPublicWorkTableViewCell {
                    cell.selectionStyle = .none
                    if let x = data{
                        cell.titleLabel.text = x[indexPath.row / 2].title!
                        cell.subLabel.text = "완료  \(x[indexPath.row / 2].complete_date!.substring(from: 11, to: 16))"
                    }
                    
                    print(indexPath.row)
                    return cell
                }
                
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
        if isNoData{
            return 125
        }else{
            if indexPath.row % 2 == 0{
                return 44
            }else{
                return 82
            }
        }
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        print("선택된 행은 \(indexPath.row) 입니다.")
    }
    
}
extension MyPageDetailPublicWorkVC {
    func didSuccessMyPageDetailPublicWork(result: MyPageDetailPublicWorkResponse) {
        data = result.data
        //taskRate = result.data?.taskRate
        print(result.message!)
        
        if data!.count != 0{
            isNoData = false
            countLabel.text = String(data!.count)
        }else{
            isNoData = true
        }
        tableView.reloadData()
        dismissIndicator()
        print(data)
    }
    
    func failedToRequestMyPageDetailPublicWork(message: String) {
        dismissIndicator()
        presentAlert(title: message)
        
    }
}
