//
//  HomeManagerQRCodeDatamanager.swift
//  Albazip
//
//  Created by 김수빈 on 2021/11/25.
//

import Foundation
import Alamofire

class HomeManagerQRCodeDatamanager {
    func downloadWeatherIcon(_ name: String, vc: HomeManagerQRCodeVC ) {
        
        let header: HTTPHeaders = [ "Content-Type":"application/json",
                                     "token":"\(UserDefaults.standard.string(forKey: "token")!)"]
        let url = "\(Constant.BASE_URL)/home/qrcode"
                AF.download(url, method: .get, headers: header)
                    .downloadProgress { progress in
                        print("Download Progress: \(progress.fractionCompleted)")
                    }.response { response in
                        if response.error == nil, let imagePath = response.fileURL?.path {
                            let image = UIImage(contentsOfFile: imagePath)
                            print(image)
                            vc.didHomeManagerQRCode(result: image!)
                            //completion(image, name, nil)
                        } else {
                            vc.failedHomeManagerQRCode(message: "QR 이미지 로드에 실패했습니다.")
                        //print(ServiceError.impossibleToGetImageData)
                        //completion(nil, name, nil)
                }
            }
        }
}

