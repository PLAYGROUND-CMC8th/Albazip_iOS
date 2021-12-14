//
//  HomeManagerTodayWorkDeleteVC.swift
//  Albazip
//
//  Created by 김수빈 on 2021/11/25.
//
protocol HomeManagerTodayWorkDeleteDelegate {
    func deletePublicWork(index : Int)
}
import Foundation
class HomeManagerTodayWorkDeleteVC: UIViewController {
    var transparentView = UIView()
    var cellIndex: Int?
    var delegate : HomeManagerTodayWorkDeleteDelegate?
    @IBOutlet var cornorView: UIView!
    @IBOutlet var backgroundView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        let window = UIApplication.shared.windows.filter {$0.isKeyWindow}.first
        transparentView.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        transparentView.frame = self.view.frame
        window?.addSubview(transparentView)
        
        cornorView.roundCorners(cornerRadius: 20, maskedCorners: [.layerMinXMinYCorner, .layerMaxXMinYCorner])
        let backgroundTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(backgroundViewTapped))
                backgroundView.addGestureRecognizer(backgroundTapGestureRecognizer)
    }
    @IBAction func btnCancel(_ sender: Any) {
        transparentView.isHidden = true
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func btnDelete(_ sender: Any) {
        transparentView.isHidden = true
        delegate?.deletePublicWork(index: cellIndex!)
        self.dismiss(animated: true, completion: nil)
    }
    @objc func backgroundViewTapped(sender: UITapGestureRecognizer) {
        transparentView.isHidden = true
        self.dismiss(animated: true, completion: nil)
    }
}
