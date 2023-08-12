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
    var selectedIndex = 0
    
    lazy var dataManager: MyPageManagerAddWorkerDatamanager = MyPageManagerAddWorkerDatamanager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        registerKeyboardNotification()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        removeKeyboardNotification()
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
        tableView.dataSource = self
        tableView.delegate = self
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
                taskList.append(TaskLists(title: totalList[x].title, content: totalList[x].content))
            }
        }
        

//        //api 호출
        let data = MyPageManagerAddWorkerInfo.shared
        let input = MyPageManagerAddWorkerRequest(rank: "알바생",title: data.title!,
                                                  workSchedule: data.workSchedule!
            .filter{$0.startTime != nil}
            .filter{$0.endTime != nil}
            .map{
                return WorkHour(startTime: $0.startTime?.replace(target: ":", with: ""), endTime: $0.endTime?.replace(target: ":", with: ""), day: $0.day)
        },
                                                  breakTime: data.breakTime!,
                                                  salary: data.salary!,
                                                  salaryType: data.salaryType!,
                                                  taskLists: taskList)
        print(input)
        dataManager.postAddWorker(input, vc: self)
        showIndicator()

    }
    
    
}

//MARK:- Keyboard
extension MyPageManagerWorkListVC {
    func registerKeyboardNotification() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)),
                                               name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)),
                                               name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    func removeKeyboardNotification() {
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc
    func keyboardWillShow(_ sender: Notification) {
        if let keyboardRect = (sender.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
              print(keyboardRect.height)
            let footerView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: keyboardRect.height))
            tableView.tableFooterView = footerView
            tableView.scrollToRow(at: IndexPath(row: selectedIndex, section: 0), at: .middle, animated: true)
        }
    }
    
    @objc
    func keyboardWillHide(_ sender: Notification) {
        let footerView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 0))
        tableView.tableFooterView = footerView
        tableView.scrollToRow(at: IndexPath(row: selectedIndex, section: 0), at: .middle, animated: true)
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
                cell.delegate = self
                cell.setupTaskWriteLabel(text: MyPageManagerAddWorkerInfo.shared.title)
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
                
                cell.myPageManagerWorkList2Delegate = self
                cell.setUpData(work: totalList[indexPath.row - 1], index: indexPath.row)
                
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
            return tableView.estimatedRowHeight
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
}

extension MyPageManagerWorkListVC: MyPageManagerWorkList3Delegate, MyPageManagerWorkList2Delegate{
    func setTitleTextField(index: Int,text: String) {
        totalList[index-1].title = text
    }
    func setSubTextField(index: Int, text:String){
        totalList[index-1].content = text
    }
    func deleteCell(index: Int) {
        totalList.remove(at: index - 1)
        tableView.reloadData()
    }

    func addWork() {
        totalList.append(WorkList(title: "",content: ""))
        tableView.reloadData()
        tableView.scrollToRow(at: IndexPath(row: totalList.count + 1, section: 0), at: .middle, animated: true)
    }
    
    func updateTextViewHeight(_ cell: UITableViewCell, _ textView: UITextView) {
        let size = textView.bounds.size
        let newSize = tableView.sizeThatFits(CGSize(width: size.width,
                                                    height: CGFloat.greatestFiniteMagnitude))
        print(newSize)
        if size.height != newSize.height {
            UIView.setAnimationsEnabled(false)
            tableView.beginUpdates()
            tableView.endUpdates()
            UIView.setAnimationsEnabled(true)
        }
    }
    
    func selectedRowIndex(index: Int) {
        selectedIndex = index
    }
}

extension MyPageManagerWorkListVC {
    func didSuccessAddWorker(_ result: MyPageManagerAddWorkerResponse) {
        dismissIndicator()
        //self.presentAlert(title: result.message)
        self.navigationController?.popToRootViewController(animated: false)
    }
    
    func failedToRequestAddWorker(message: String) {
        dismissIndicator()
        self.presentAlert(title: message)
    }
}

extension MyPageManagerWorkListVC: MyPageManagerWorkList1TableViewCellDelegate {
    func showHelpWriteBottomSheet() {
        let bottomSheetVC = HelpWrittingBottomSheetViewController()
        bottomSheetVC.modalPresentationStyle = .overFullScreen
        present(bottomSheetVC, animated: false, completion: nil)
    }
}
