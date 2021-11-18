//
//  HomeWorkerQRCodeVC.swift
//  Albazip
//
//  Created by 김수빈 on 2021/11/15.
//

import Foundation
class HomeWorkerQRCodeVC: UIViewController{
    @IBOutlet var readerView: ReaderView!
    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var readRect: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dateLabel.text = "yy. MM. dd EEEE".stringFromDate()
        self.readerView.delegate = self
        var x = readRect.bounds
        //self.readButton.layer.masksToBounds = true
        //self.readButton.layer.cornerRadius = 15
        self.readerView.start()
        //readButton.isSelected = self.readerView.isRunning
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        if !self.readerView.isRunning {
            self.readerView.stop(isButtonTap: false)
        }
    }
    @IBAction func btnCancel(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}
extension HomeWorkerQRCodeVC: ReaderViewDelegate {
    func readerComplete(status: ReaderStatus) {

        var title = ""
        var message = ""
        switch status {
        case let .success(code):
            guard let code = code else {
                title = "에러"
                message = "QR코드 or 바코드를 인식하지 못했습니다.\n다시 시도해주세요."
                break
            }

            title = "알림"
            //message = "인식성공\n\(code)"
            message = "HH:mm".stringFromDate() + "에 출근이 기록되었습니다."
        case .fail:
            title = "에러"
            message = "QR코드 or 바코드를 인식하지 못했습니다.\n다시 시도해주세요."
        case let .stop(isButtonTap):
            if isButtonTap {
                title = "알림"
                message = "바코드 읽기를 멈추었습니다."
                //self.readButton.isSelected = readerView.isRunning
            } else {
                //self.readButton.isSelected = readerView.isRunning
                return
            }
        }

        //let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)

        //let okAction = UIAlertAction(title: "확인", style: .default, handler: nil)

        //alert.addAction(okAction)
        //self.present(alert, animated: true, completion: nil)
        presentBottomAlert(message: message)
    }
}
