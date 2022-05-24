//
//  StoreClosedDayCell.swift
//  Albazip
//
//  Created by 김수빈 on 2022/05/22.
//

import UIKit
protocol StoreClosedDayDelegate {
    func btnDayClicked(index: Int)
}
class StoreClosedDayCell: UITableViewCell {
    @IBOutlet var btnNoBreak: UIButton!
    @IBOutlet var btnMon: UIButton!
    @IBOutlet var btnTue: UIButton!
    @IBOutlet var btnWed: UIButton!
    @IBOutlet var btnThu: UIButton!
    @IBOutlet var btnFri: UIButton!
    @IBOutlet var btnSat: UIButton!
    @IBOutlet var btnSun: UIButton!
    @IBOutlet var btnBreak: UIButton!
    var delegate: StoreClosedDayDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBAction func btnNoBreak(_ sender: Any){
        delegate?.btnDayClicked(index: 0)
    }
    @IBAction func btnMon(_ sender: Any) {
        delegate?.btnDayClicked(index: 1)
    }
    @IBAction func btnTue(_ sender: Any) {
        delegate?.btnDayClicked(index: 2)
    }
    @IBAction func btnWed(_ sender: Any) {
        delegate?.btnDayClicked(index: 3)
    }
    @IBAction func btnThu(_ sender: Any) {
        delegate?.btnDayClicked(index: 4)
    }
    @IBAction func btnFri(_ sender: Any) {
        delegate?.btnDayClicked(index: 5)
    }
    @IBAction func btnSat(_ sender: Any) {
        delegate?.btnDayClicked(index: 6)
    }
    @IBAction func btnSun(_ sender: Any) {
        delegate?.btnDayClicked(index: 7)
    }
    @IBAction func btnBreak(_ sender: Any) {
        delegate?.btnDayClicked(index: 8)
    }
    
    func setUp(btnArray: [Int]){
        setBtnState(btn: btnNoBreak,state: btnArray[0])
        setBtnState(btn: btnMon,state: btnArray[1])
        setBtnState(btn: btnTue,state: btnArray[2])
        setBtnState(btn: btnWed,state: btnArray[3])
        setBtnState(btn: btnThu,state: btnArray[4])
        setBtnState(btn: btnFri,state: btnArray[5])
        setBtnState(btn: btnSat,state: btnArray[6])
        setBtnState(btn: btnSun,state: btnArray[7])
        setBtnState(btn: btnBreak,state: btnArray[8])
    }
    
    func setBtnState(btn: UIButton, state: Int){
        if state == 0{
            btn.backgroundColor = .none
            btn.setTitleColor(#colorLiteral(red: 0.4352484345, green: 0.4353259802, blue: 0.4352382123, alpha: 1), for: .normal)
            btn.borderColor = #colorLiteral(red: 0.9245131612, green: 0.9296400547, blue: 0.9250692725, alpha: 1)
        }else if state == 1{
            btn.backgroundColor = #colorLiteral(red: 1, green: 0.849331677, blue: 0.3616983294, alpha: 1)
            btn.setTitleColor(#colorLiteral(red: 0.2038974464, green: 0.2039384246, blue: 0.2038920522, alpha: 1), for: .normal)
            btn.borderColor = #colorLiteral(red: 1, green: 0.8398586512, blue: 0.2317804694, alpha: 1)
        }else{
            btn.backgroundColor = #colorLiteral(red: 0.9371625781, green: 0.9373195171, blue: 0.9371418357, alpha: 1)
            btn.setTitleColor(#colorLiteral(red: 0.4352484345, green: 0.4353259802, blue: 0.4352382123, alpha: 1), for: .normal)
            btn.borderColor = #colorLiteral(red: 0.9371625781, green: 0.9373195171, blue: 0.9371418357, alpha: 1)
        }
    }
}
