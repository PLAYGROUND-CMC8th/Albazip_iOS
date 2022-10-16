//
//  MyPageManagerWorkerPositionTableViewCell.swift
//  Albazip
//
//  Created by 김수빈 on 2021/11/09.
//

import UIKit

class MyPageManagerWorkerPositionTableViewCell: UITableViewCell {

    @IBOutlet var workTimeLabel: UILabel!
    @IBOutlet var breakTimeLabel: UILabel!
    @IBOutlet var salaryLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setCell(data:  MyPageManagerWorkerPositionData){
        self.breakTimeLabel.text = data.breakTime ?? ""
        if data.salaryType == 0{
            self.salaryLabel.text = "시급 " + data.salary!.insertComma +  "원"
        }else if data.salaryType == 1{
            self.salaryLabel.text = "주급 " + data.salary!.insertComma +  "원"
        }else{
            self.salaryLabel.text = "월급 " + data.salary!.insertComma +  "원"
        }

        var workDay = ""
        guard let workSchedule = data.workSchedule else {
            self.workTimeLabel.text = workDay
            return
        }
        for (index, workday) in workSchedule.enumerated(){
            let startTime = (workday.startTime ?? "").insertTime
            let endTime = (workday.endTime ?? "").insertTime
            let workHour = SysUtils.calculateTime(workHour: WorkHour(startTime: startTime, endTime: endTime, day: workday.day))
            workDay += "\(workday.day) \(startTime) ~ \(endTime)(\(workHour))"
            if workSchedule.count != index + 1{
                workDay += "\n"
            }
        }
        let attrString = NSMutableAttributedString(string: workDay)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 6
        attrString.addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphStyle, range: NSMakeRange(0, attrString.length))
        self.workTimeLabel.attributedText = attrString
    }
}
