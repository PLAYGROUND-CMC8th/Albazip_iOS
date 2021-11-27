//
//  HomeManagerUnClearAlertVC.swift
//  Albazip
//
//  Created by 김수빈 on 2021/11/27.
//

protocol CheckCompleteWorkAlertDelegate {
    func readyToUnCkeckWork(taskId: Int)
}
class HomeManagerUnClearAlertVC: UIViewController{
    var transparentView = UIView()
    var taskId = -1
    var delegate: CheckCompleteWorkAlertDelegate?
    @IBOutlet var cornorView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        let window = UIApplication.shared.windows.filter {$0.isKeyWindow}.first
        transparentView.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        transparentView.frame = self.view.frame
        window?.addSubview(transparentView)
    }
    @IBAction func btnCancel(_ sender: Any) {
        self.transparentView.isHidden = true
        self.dismiss(animated: true)
    }
    @IBAction func btnDelete(_ sender: Any) {
        self.transparentView.isHidden = true
        self.delegate?.readyToUnCkeckWork(taskId: taskId)
        self.dismiss(animated: true)
    }
}
