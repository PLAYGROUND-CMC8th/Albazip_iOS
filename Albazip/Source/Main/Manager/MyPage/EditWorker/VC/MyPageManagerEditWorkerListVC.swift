//
//  MyPageManagerEditWorkerListVC.swift
//  Albazip
//
//  Created by 김수빈 on 2021/11/18.
//

import Foundation

struct EditWorkList{
    var title: String
    var content: String?
    var id:Int?
}
class MyPageManagerEditWorkerListVC: UIViewController{
    // 이전 뷰에서 받아올 정보
    var positionId = 0
    @IBOutlet var btnNext: UIButton!
    @IBOutlet var tableView: UITableView!
    var totalCount = 0
    var totalList = [EditWorkList]()
    var taskList = [EditTaskLists2]()
    // Datamanager
    lazy var dataManager: MyPageManagerEditWorkerListDataManger = MyPageManagerEditWorkerListDataManger()
    var isFirstKeyboardSHow = true
    var footer = UIView()
    override func viewDidLoad() {
        super.viewDidLoad()
        print(taskList)
        var i = 0
        while i < taskList.count{
            totalList.append(EditWorkList(title: taskList[i].title, content: taskList[i].content, id: taskList[i].id))
            i += 1
        }
        setupTableView()
        setUI()
    }
    //MARK:- View Setup
    func setUI(){
        self.tabBarController?.tabBar.isHidden = true
        self.dismissKeyboardWhenTappedAround()
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
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
                    
                    return presentBottomAlert(message: "업무명을 입력해주세요.")
                }
                
                taskList.append(EditTaskLists2(title: totalList[x].title ,content: totalList[x].content ?? nil, id: totalList[x].id ?? nil))
            }
            print("완료")
            
        }else{
            print("totalList가 null 임")
        }
        //api 호출
        let data = MyPageManagerAddWorkerInfo.shared
        let input = MyPageManagerEditWorkerRequest(
            rank: "알바생",
            title: data.title!,
            workSchedule: data.workSchedule!
                .filter{$0.startTime != nil}
                .filter{$0.endTime != nil}
                .map{
                    return WorkHour(startTime: $0.startTime?.replace(target: ":", with: ""), endTime: $0.endTime?.replace(target: ":", with: ""), day: $0.day)
                },
            breakTime: data.breakTime!,
            salary: data.salary!,
            salaryType: {
                switch(data.salaryType ?? "시급"){
                case "시급":
                    return 0
                case "주급":
                    return 1
                default:
                    return 2
                }
            }(),
            taskLists: taskList.map{
                TaskLists(title: $0.title, content: $0.content ?? "")
            }
        )

        showIndicator()
        dataManager.getMyPageManagerEditWorkerList(input, vc: self, index: positionId)
        
    }
    @objc internal func keyboardWillShow(_ notification : Notification?) -> Void {
            print("키보드 올림")
            var _kbSize:CGSize!
                
            if let info = notification?.userInfo {

                let frameEndUserInfoKey = UIResponder.keyboardFrameEndUserInfoKey
                    
                    //  Getting UIKeyboardSize.
                if let kbFrame = info[frameEndUserInfoKey] as? CGRect {
                        
                let screenSize = UIScreen.main.bounds
                        
                let intersectRect = kbFrame.intersection(screenSize)
                        
                if intersectRect.isNull {
                    _kbSize = CGSize(width: screenSize.size.width, height: 0)
                } else{
                    _kbSize = intersectRect.size
                }
                    print("Your Keyboard Size \(_kbSize)")
                    if isFirstKeyboardSHow{
                        
                        footer = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: _kbSize.height))
                        tableView.tableFooterView = footer
                        tableView.reloadData()
                        isFirstKeyboardSHow = false
                        
                    }
                    
                }
            }
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
                cell.cellTitle.text = "근무자 편집 시 다음 근무일부터 모든 변경사항이 적용됩니다."
                cell.cellHeight.constant = 47
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
            return 124//143
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
            
        totalList.append(EditWorkList(title: "",content: "", id: nil))
        print(totalList)
        tableView.reloadData()
        print(totalList)
    }
    
    
}
extension MyPageManagerEditWorkerListVC {
    func didSuccessMyPageManagerEditWorkerList(result: MyPageEditWorkerListResponse) {
        dismissIndicator()
        backTwo()
    }
    
    func failedToRequestMyPageEditWorkerList(message: String) {
        dismissIndicator()
        presentAlert(title: message)
    }
    func backTwo() {
        let viewControllers: [UIViewController] = self.navigationController!.viewControllers as [UIViewController]
        self.navigationController!.popToViewController(viewControllers[viewControllers.count - 3], animated: false)
    }
}
