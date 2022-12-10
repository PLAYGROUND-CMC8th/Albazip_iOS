//
//  HomeManagerAddPublicWorkVC.swift
//  Albazip
//
//  Created by 김수빈 on 2021/11/13.
//

import Foundation
class HomeManagerAddPublicWorkVC: UIViewController{
    var totalCount = 0
    var totalList = [WorkList]()
    var taskList = [TaskLists]()
    var isFirstKeyboardSHow = true
    var footer = UIView()
    @IBOutlet var tableView: UITableView!
    // Datamanager
    lazy var dataManager: HomeManagerAddPublicWorkDatamanager = HomeManagerAddPublicWorkDatamanager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        setupTableView()
        //setKeyboardObserver()
    }
    @IBAction func btnCancel(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    //MARK:- View Setup
    func setUI(){
        self.dismissKeyboardWhenTappedAround()
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
    }
    func setupTableView() {
        
        tableView.register(UINib(nibName: "HomeManagerAddPublicWorkTableViewCell", bundle: nil),
                           forCellReuseIdentifier: "HomeManagerAddPublicWorkTableViewCell")
        tableView.register(UINib(nibName: "MyPageManagerWorkList2TableViewCell", bundle: nil),forCellReuseIdentifier: "MyPageManagerWorkList2TableViewCell")
        tableView.register(UINib(nibName: "MyPageManagerWorkList3TableViewCell", bundle: nil),forCellReuseIdentifier: "MyPageManagerWorkList3TableViewCell")
        //MyPageManagerWriteCommunityTableViewCell
        tableView.dataSource = self
        tableView.delegate = self
        //tableView.estimatedRowHeight = 74
        tableView.rowHeight = UITableView.automaticDimension
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
        showIndicator()
        dataManager.postHomeManagerAddPublicWork(HomeManagerAddPublicWorkRequest(coTaskList: taskList), delegate: self)
        
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
        print("선택된 행은 \(indexPath.row) 입니다.")
        
    }
}
extension HomeManagerAddPublicWorkVC: MyPageManagerWorkList3Delegate, MyPageManagerWorkList2Delegate{
    
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
}
extension HomeManagerAddPublicWorkVC {
    func didSuccessHomeManagerAddPublicWork(result: HomeManagerAddPublicWorkResponse) {
        
        print(result.message)
        
        dismissIndicator()
        self.navigationController?.popViewController(animated: true)
    }
    
    func failedToRequestHomeManagerAddPublicWork(message: String) {
        dismissIndicator()
        presentAlert(title: message)
    }
}
