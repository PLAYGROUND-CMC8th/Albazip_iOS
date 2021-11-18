//
//  MyPageManagerEditWorkerListVC.swift
//  Albazip
//
//  Created by 김수빈 on 2021/11/18.
//

import Foundation
class MyPageManagerEditWorkerListVC: UIViewController{
    // 이전 뷰에서 받아올 정보
    var positionId = 0
    @IBOutlet var btnNext: UIButton!
    @IBOutlet var tableView: UITableView!
    var totalCount = 0
    var totalList = [WorkList]()
    var taskList = [EditTaskLists]()
    // Datamanager
    lazy var dataManager: MyPageManagerEditWorkerListDataManger = MyPageManagerEditWorkerListDataManger()
    override func viewDidLoad() {
        super.viewDidLoad()
        print(taskList)
        var i = 0
        while i < taskList.count{
            totalList.append(WorkList(title: taskList[i].title, content: taskList[i].content))
            i += 1
        }
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
        var taskList2 = [EditTaskLists2]()
        var i = 0
        while i < taskList.count{
            taskList2.append(EditTaskLists2(title: taskList[i].title, content: taskList[i].content, id: i+1))
            i += 1
        }
        taskList.removeAll()
     
        if totalList.count != 0{
            for x in 0...totalList.count - 1{
                if totalList[x].title == ""{
                    
                    return presentBottomAlert(message: "업무명을 입력해주세요.")
                }
                
                taskList.append(EditTaskLists(title: totalList[x].title ,content: totalList[x].content, id: x+1))
            }
            print("완료")
            
        }else{
            print("totalList가 null 임")
        }
        //api 호출
        let data = MyPageManagerAddWorkerInfo.shared
        var salaryType2 = 0
        if data.salaryType == "시급"{
            salaryType2 = 0
        }else if data.salaryType == "주급"{
            salaryType2 = 1
        }else{
            salaryType2 = 2
        }
        let input = MyPageManagerEditWorkerData2(rank: data.rank!, title: data.title!, startTime: data.startTime!, endTime: data.endTime!,  workDay: data.workDays!, breakTime: data.breakTime!, salary: data.salary!, salaryType: salaryType2, taskList: taskList2)
        taskList2.removeAll()
        print(input)
        dataManager.getMyPageManagerEditWorkerList(input, vc: self, index: positionId)
        showIndicator()
        
    }
}
//MARK:- Table View Data Source

extension MyPageManagerEditWorkerListVC: UITableViewDataSource, UITableViewDelegate {
    
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
extension MyPageManagerEditWorkerListVC: MyPageManagerWorkList3Delegate, MyPageManagerWorkList2Delegate{
    
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
extension MyPageManagerEditWorkerListVC {
    func didSuccessMyPageManagerEditWorkerList(result: MyPageEditWorkerListResponse) {
        
        dismissIndicator()
    }
    
    func failedToRequestMyPageEditWorkerList(message: String) {
        dismissIndicator()
        presentAlert(title: message)
    }
}
