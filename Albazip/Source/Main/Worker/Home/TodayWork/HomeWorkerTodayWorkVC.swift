//
//  HomeWorkerTodayWorkVC.swift
//  Albazip
//
//  Created by 김수빈 on 2021/11/15.
//

import Foundation
class HomeWorkerTodayWorkVC: UIViewController{
    
    @IBOutlet var segment: UISegmentedControl!
    @IBOutlet var tableView: UITableView!
    var segValue = 0 // 0이면 공동업무, 1이면 개인업무!
    override func viewDidLoad() {
        super.viewDidLoad()
        print(segValue)
        setUI()
    }
    func setUI() {
        
        segment.cornerRadius = segment.bounds.height / 2
        let attributes = [
            NSAttributedString.Key.foregroundColor :  #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1),
            NSAttributedString.Key.font : UIFont(name: "AppleSDGothicNeo-Bold", size: 16) as Any
        ] as [NSAttributedString.Key : Any]
        segment.setTitleTextAttributes(attributes , for: .selected)
        
        let attributes2 = [
            NSAttributedString.Key.foregroundColor : #colorLiteral(red: 0.6430723071, green: 0.6431827545, blue: 0.6430577636, alpha: 1),
            NSAttributedString.Key.font : UIFont(name: "AppleSDGothicNeo-Medium", size: 16) as Any
        ] as [NSAttributedString.Key : Any]
        segment.setTitleTextAttributes(attributes2 , for: .normal)
        /*
        //corner radius
        let cornerRadius = segment.bounds.height / 2
        let maskedCorners: CACornerMask = [.layerMinXMinYCorner, .layerMinXMaxYCorner, .layerMaxXMinYCorner, .layerMaxXMaxYCorner]
        //background
        segment.clipsToBounds = true
        segment.layer.cornerRadius = cornerRadius
        segment.layer.maskedCorners = maskedCorners*/
        segment.selectedSegmentIndex = segValue
        
    }
    @IBAction func btnCancel(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}
