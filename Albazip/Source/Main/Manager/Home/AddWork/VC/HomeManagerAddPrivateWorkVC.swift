//
//  HomeManagerAddPrivateWorkVC.swift
//  Albazip
//
//  Created by 김수빈 on 2021/11/13.
//

import Foundation
class HomeManagerAddPrivateWorkVC: UIViewController{
    @IBOutlet var tableView: UITableView!
    var totalCount = 0
    var totalList = [WorkList]()
    var taskList = [TaskLists]()
    var selectedItem = -1
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        setupTableView()
    }
    
    @IBAction func btnCancel(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    //MARK:- View Setup
    func setUI(){
        
        self.dismissKeyboardWhenTappedAround()
    }
    func setupTableView() {
        
        tableView.register(UINib(nibName: "HomeManagerAddPublicWorkTableViewCell", bundle: nil),
                           forCellReuseIdentifier: "HomeManagerAddPublicWorkTableViewCell")
        tableView.register(UINib(nibName: "MyPageManagerWorkList2TableViewCell", bundle: nil),forCellReuseIdentifier: "MyPageManagerWorkList2TableViewCell")
        tableView.register(UINib(nibName: "MyPageManagerWorkList3TableViewCell", bundle: nil),forCellReuseIdentifier: "MyPageManagerWorkList3TableViewCell")
        tableView.register(UINib(nibName: "HomeManagerAddPrivateWorkTableViewCell", bundle: nil),forCellReuseIdentifier: "HomeManagerAddPrivateWorkTableViewCell")
        //HomeManagerAddPrivateWorkTableViewCell
        //MyPageManagerWriteCommunityTableViewCell
        tableView.dataSource = self
        tableView.delegate = self
        //tableView.estimatedRowHeight = 74
    }
    @IBAction func btnNext(_ sender: Any) {
        taskList.removeAll()
     
        if totalList.count != 0{
            for x in 0...totalList.count - 1{
                if totalList[x].title == ""{
                    
                    return presentBottomAlert(message: "업무명을 입력해주세요.")
                }
                taskList.append(TaskLists(title: totalList[x].title, content: totalList[x].content))
            }
            print("완료")
            
        }else{
            print("totalList가 null 임")
           
            
        }
        /*
        //api 호출
        let data = MyPageManagerAddWorkerInfo.shared
        let input = MyPageManagerAddWorkerRequest(rank: data.rank!, title: data.title!, startTime: data.startTime!, endTime: data.endTime!,  workDays: data.workDays!, breakTime: data.breakTime!, salary: data.salary!, salaryType: data.salaryType!, taskLists: taskList)
        print(input)
        dataManager.postAddWorker(input, vc: self)
        showIndicator()
        //self.navigationController?.popViewController(animated: true)
 */
    }
}
//MARK:- Table View Data Source

extension HomeManagerAddPrivateWorkVC: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return totalList.count + 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.row {
        case 0:
            if let cell = tableView.dequeueReusableCell(withIdentifier: "HomeManagerAddPublicWorkTableViewCell") as? HomeManagerAddPublicWorkTableViewCell {
                cell.titleLabel.text = "포지션 선택"
                cell.selectionStyle = .none
                return cell
            }
        case 1:
            if let cell = tableView.dequeueReusableCell(withIdentifier: "HomeManagerAddPrivateWorkTableViewCell") as? HomeManagerAddPrivateWorkTableViewCell {
                cell.delegate = self
                //cell.titleLabel.text = "포지션 선택"
                //cell.homeManagerAddPrivateWorkCollectionViewCellDelegate = self
                cell.selectionStyle = .none
                return cell
            }
        case totalList.count+2:
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
                cell.titleLabel.text = totalList[indexPath.row - 2].title
                cell.subLabel.text = totalList[indexPath.row - 2].content
                
                
                print(indexPath.row)
                return cell
            }
        }
        return UITableViewCell()
    }
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat{
        switch indexPath.row {
        case 0:
            return 124
        case 1:
            return 110
        case totalList.count+2:
            return 60
        default:
            
        return 110
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("선택된 행은 \(indexPath.row) 입니다.")
        
    }
}
extension HomeManagerAddPrivateWorkVC: MyPageManagerWorkList3Delegate, MyPageManagerWorkList2Delegate{
    
    func setTitleTextField(index: Int,text: String) {
        totalList[index-2].title = text
        print(totalList)
    }
    func setSubTextField(index: Int, text:String){
        totalList[index-2].content = text
        print(totalList)
    }
    func deleteCell(index: Int) {
        totalList.remove(at: index - 2)
        print(totalList)
        tableView.reloadData()
        print(totalList)
    }

    func addWork() {
        if selectedItem != -1{
            totalList.append(WorkList(title: "",content: ""))
            print(totalList)
            tableView.reloadData()
            print(totalList)
        }else{
            presentBottomAlert(message: "먼저 업무를 추가할 포지션을 선택해주세요.")
        }
        
    }
    
    
}

extension  HomeManagerAddPrivateWorkVC: HomeManagerAddPrivateWorkTableViewCellDelegate{
    func changePostition(index: Int) {
        selectedItem = index
        print("선택된 아이템 \(index)")
    }
}

