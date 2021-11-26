//
//  CommunityWorkerNoticeDetailTableViewCell.swift
//  Albazip
//
//  Created by 김수빈 on 2021/11/24.
//

import UIKit

class CommunityWorkerNoticeDetailTableViewCell: UITableViewCell {
    var cellCount = 3
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var completePeopleView: UIView!
    @IBOutlet var completePeopleViewHeight: NSLayoutConstraint!
    @IBOutlet var tableView: UITableView!
    @IBOutlet var positionLabel: UILabel!
    @IBOutlet var personCount: UILabel!
    @IBOutlet var personView: UIView!
    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var detailLabel: UILabel!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var profileImage: UIImageView!
    
    @IBOutlet var image1: UIImageView!
    @IBOutlet var image2: UIImageView!
    
    @IBOutlet var height1: NSLayoutConstraint!
    @IBOutlet var height2: NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        completePeopleView.isHidden = true
        // view 클릭 시, 함수 정의
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(personViewTapped))
        personView.addGestureRecognizer(tapGestureRecognizer)
        completePeopleViewHeight.constant = CGFloat(45 + 36 * cellCount)
        //이미지뷰 동그랗게
        profileImage.layer.cornerRadius = profileImage.frame.width / 2
        profileImage.clipsToBounds = true
        
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
    
}
extension CommunityWorkerNoticeDetailTableViewCell: UITableViewDataSource,UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return cellCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            if let cell = tableView.dequeueReusableCell(withIdentifier: "HomeWorkerCompletePeopleTableViewCell") as? HomeWorkerCompletePeopleTableViewCell {
                cell.selectionStyle = .none
                
                print(indexPath.row)
                return cell
            }
        
        return UITableViewCell()
    }
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat{
        
            return 36
        
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("선택된 행은 \(indexPath.row) 입니다.")
    }
    
}
