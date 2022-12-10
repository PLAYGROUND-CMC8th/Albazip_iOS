//
//  HomeManagerAddPublicWorkVC.swift
//  Albazip
//
//  Created by 김수빈 on 2021/11/13.
//

import Foundation
class HomeManagerAddPublicWorkVC: UIViewController{
    var totalList = [WorkList]()
    var taskList = [TaskLists]()
    var selectedIndex = 0

    @IBOutlet var tableView: UITableView!
    
    lazy var dataManager: HomeManagerAddPublicWorkDatamanager = HomeManagerAddPublicWorkDatamanager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        setupTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        registerKeyboardNotification()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        removeKeyboardNotification()
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
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = UITableView.automaticDimension
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
        
        showIndicator()
        dataManager.postHomeManagerAddPublicWork(HomeManagerAddPublicWorkRequest(coTaskList: taskList), delegate: self)
        
    }
}
//MARK:- Keyboard
extension HomeManagerAddPublicWorkVC {
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
extension HomeManagerAddPublicWorkVC: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return totalList.count + 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.row {
        case 0:
            if let cell = tableView.dequeueReusableCell(withIdentifier: "HomeManagerAddPublicWorkTableViewCell") as? HomeManagerAddPublicWorkTableViewCell {
                cell.titleLabel.text = "업무 내용"
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
            return 124
        case totalList.count+1:
            return 60
        default:
            return UITableView.automaticDimension
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}
extension HomeManagerAddPublicWorkVC: MyPageManagerWorkList3Delegate, MyPageManagerWorkList2Delegate{
    
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
extension HomeManagerAddPublicWorkVC {
    func didSuccessHomeManagerAddPublicWork(result: HomeManagerAddPublicWorkResponse) {
        dismissIndicator()
        self.navigationController?.popViewController(animated: true)
    }
    
    func failedToRequestHomeManagerAddPublicWork(message: String) {
        dismissIndicator()
        presentAlert(title: message)
    }
}
