//
//  MyPageManagerWorkListVC.swift
//  Albazip
//
//  Created by 김수빈 on 2021/11/05.
//

import Foundation
import UIKit

struct WorkList{
    var title: String
    var content: String
}

class MyPageManagerWorkListVC: UIViewController{
    
    
    @IBOutlet var tableView: UITableView!
    var totalCount = 0
    var totalList = [WorkList]()
    var taskList = [TaskLists]()
    // Datamanager
    lazy var dataManager: MyPageManagerAddWorkerDatamanager = MyPageManagerAddWorkerDatamanager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setUI()
    }
    //MARK:- View Setup
    func setUI(){
        self.tabBarController?.tabBar.isHidden = true
        self.dismissKeyboardWhenTappedAround()
    }
    func setupTableView() {
        
        tableView.register(UINib(nibName: "MyPageManagerWorkList1TableViewCell", bundle: nil),
                           forCellReuseIdentifier: "MyPageManagerWorkList1TableViewCell")
        tableView.register(UINib(nibName: "MyPageManagerWorkList2TableViewCell", bundle: nil),
                           forCellReuseIdentifier: "MyPageManagerWorkList2TableViewCell")
        tableView.register(UINib(nibName: "MyPageManagerWorkList3TableViewCell", bundle: nil),
                           forCellReuseIdentifier: "MyPageManagerWorkList3TableViewCell")
        //MyPageManagerWriteCommunityTableViewCell
        tableView.dataSource = self
        tableView.delegate = self
        //tableView.estimatedRowHeight = 74
    }
    
    @IBAction func btnCancel(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnNext(_ sender: Any) {
        taskList.removeAll()
     
        if totalList.count != 0{
            for x in 0...totalList.count - 1{
                if totalList[x].title == ""{
                    return showMessage(message: "업무명을 입력해주세요.", controller: self)
                }
                taskList.append(TaskLists(title: totalList[x].title, content: totalList[x].content))
            }
            print("완료")
            
        }else{
            print("totalList가 null 임")
           
            
        }
        //api 호출
        let data = MyPageManagerAddWorkerInfo.shared
        let input = MyPageManagerAddWorkerRequest(rank: data.rank!, title: data.title!, startTime: data.startTime!, endTime: data.endTime!,  workDays: data.workDays!, breakTime: data.breakTime!, salary: data.salary!, salaryType: data.salaryType!, taskLists: taskList)
        print(input)
        dataManager.postAddWorker(input, vc: self)
        showIndicator()
        //self.navigationController?.popViewController(animated: true)
    }
    
    
    
}

//MARK:- Table View Data Source

extension  MyPageManagerWorkListVC: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return totalList.count + 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.row {
        case 0:
            if let cell = tableView.dequeueReusableCell(withIdentifier: "MyPageManagerWorkList1TableViewCell") as? MyPageManagerWorkList1TableViewCell {
                cell.selectionStyle = .none
                return cell
            }
        
        case totalList.count+1:
            if let cell = tableView.dequeueReusableCell(withIdentifier: "MyPageManagerWorkList3TableViewCell") as? MyPageManagerWorkList3TableViewCell {
                cell.selectionStyle = .none
                cell.myPageManagerWorkList3Delegate = self
                print(indexPath.row)
                return cell
            }
        default:
            if let cell = tableView.dequeueReusableCell(withIdentifier: "MyPageManagerWorkList2TableViewCell") as? MyPageManagerWorkList2TableViewCell {
                
                cell.selectionStyle = .none
                cell.cellIndex = indexPath.row
                cell.myPageManagerWorkList2Delegate = self
                cell.titleLabel.text = totalList[indexPath.row - 1].title
                cell.subLabel.text = totalList[indexPath.row - 1].content
                
                
                print(indexPath.row)
                return cell
            }
        }
        return UITableViewCell()
    }
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat{
        switch indexPath.row {
        case 0:
            return 143
        case totalList.count+1:
            return 60
        default:
            
        return 110
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("선택된 행은 \(indexPath.row) 입니다.")
        
    }
}

extension MyPageManagerWorkListVC: MyPageManagerWorkList3Delegate, MyPageManagerWorkList2Delegate{
    
    func setTitleTextField(index: Int,text: String) {
        totalList[index-1].title = text
        print(totalList)
    }
    func setSubTextField(index: Int, text:String){
        totalList[index-1].content = text
        print(totalList)
    }
    func deleteCell(index: Int) {
        totalList.remove(at: index - 1)
        print(totalList)
        tableView.reloadData()
        print(totalList)
    }

    func addWork() {
            
        totalList.append(WorkList(title: "",content: ""))
        print(totalList)
        tableView.reloadData()
        print(totalList)
    }
    
    
}

extension MyPageManagerWorkListVC {
    func didSuccessAddWorker(_ result: MyPageManagerAddWorkerResponse) {
        dismissIndicator()
        self.presentAlert(title: result.message)
        self.navigationController?.popViewController(animated: true)
    }
    
    func failedToRequestAddWorker(message: String) {
        dismissIndicator()
        self.presentAlert(title: message)
    }
}
