//
//  MyPageDetailClearWorkMonthVC.swift
//  Albazip
//
//  Created by 김수빈 on 2021/11/11.
//

import Foundation
class MyPageDetailClearWorkMonthVC: UIViewController{
    
    var month = ""
    var year = ""
    //관리자라면 근무자 정보 받아와야한다.
    var positionId = -1 // 근무자이면 디폴트값 -1
    
    @IBOutlet var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
    }
    
    func setupTableView() {
        
        //tableView.register(UINib(nibName: "MyPageDetailCountTableViewCell", bundle: nil), forCellReuseIdentifier: "MyPageDetailCountTableViewCell")
        let header = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 18))
        header.backgroundColor = #colorLiteral(red: 0.9999018312, green: 1, blue: 0.9998798966, alpha: 1)
        tableView.tableHeaderView = header
        let todayGoodsCellNib = UINib(nibName: "MyPageDetailClearWorkTableViewCell", bundle: nil)
        self.tableView.register(todayGoodsCellNib, forCellReuseIdentifier: "MyPageDetailClearWorkTableViewCell")
        
        tableView.dataSource = self
        tableView.delegate = self
    }
    func goDayPage(){
        guard let nextVC = self.storyboard?.instantiateViewController(identifier: "MyPageDetailClearWorkDayVC") as? MyPageDetailClearWorkDayVC else {return}
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
    @IBAction func btnCancel(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
}

//MARK:- Table View Data Source

extension MyPageDetailClearWorkMonthVC: UITableViewDataSource,UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
 
            if let cell = tableView.dequeueReusableCell(withIdentifier: "MyPageDetailClearWorkTableViewCell") as? MyPageDetailClearWorkTableViewCell {
                cell.selectionStyle = .none
                return cell
            }
        
        
        return UITableViewCell()
    }
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat{
        
            return 125
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("선택된 행은 \(indexPath.row) 입니다.")
        goDayPage()
    }
    
}
