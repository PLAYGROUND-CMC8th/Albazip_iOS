//
//  HomeWorkerPublicWorkCompleteHeaderTableViewCell.swift
//  Albazip
//
//  Created by 김수빈 on 2021/11/21.
//

import UIKit

class HomeWorkerPublicWorkCompleteHeaderTableViewCell: UITableViewCell {
    var comWorker: [HomeWorkerComWorkerList]?
    @IBOutlet var completePeopleViewHeight: NSLayoutConstraint!
    @IBOutlet var personView: UIView!
    @IBOutlet var countLabel: UILabel!
    @IBOutlet var completePeopleView: UIView!
    @IBOutlet var tableView: UITableView!
    @IBOutlet var peopleCountLabel: UILabel!
    var cellCount = 3
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        completePeopleView.isHidden = true
        // view 클릭 시, 함수 정의
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(personViewTapped))
        personView.addGestureRecognizer(tapGestureRecognizer)
        completePeopleViewHeight.constant = CGFloat(45 + 36 * cellCount)
        setTableView()
    }
    func setTableView(){
        
        tableView.register(UINib(nibName: "HomeWorkerCompletePeopleTableViewCell", bundle: nil),
                           forCellReuseIdentifier: "HomeWorkerCompletePeopleTableViewCell")
        tableView.dataSource = self
        tableView.delegate = self
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @objc func personViewTapped(sender: UITapGestureRecognizer) {
        print("몇명일까요")
        completePeopleView.isHidden.toggle()
    }
    //데이터 가져올 함수
    func setCell(data: [HomeWorkerComWorkerList])  {
        comWorker = data
        peopleCountLabel.text = String(data.count)
        completePeopleViewHeight.constant = CGFloat(45 + 36 * data.count)
        self.tableView.reloadData()
    }

}
extension HomeWorkerPublicWorkCompleteHeaderTableViewCell: UITableViewDataSource,UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if let data = comWorker{
            return data.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            if let cell = tableView.dequeueReusableCell(withIdentifier: "HomeWorkerCompletePeopleTableViewCell") as? HomeWorkerCompletePeopleTableViewCell {
                cell.selectionStyle = .none
                if let data = comWorker{
                    cell.countLabel.text = String(data[indexPath.row].count!)
                    let url = URL(string: data[indexPath.row].image!)
                    cell.profileImage.kf.setImage(with: url)
                    cell.nameLabel.text = data[indexPath.row].worker!
                }
                print(indexPath.row)
                return cell
            }
        
        return UITableViewCell()
    }
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat{
        if let data = comWorker{
            return 36
        }else{
            return 0
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("선택된 행은 \(indexPath.row) 입니다.")
    }
    
}
