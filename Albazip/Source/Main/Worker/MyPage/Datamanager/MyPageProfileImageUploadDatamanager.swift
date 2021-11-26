//
//  MyPageProfileImageUploadDatamanager.swift
//  Albazip
//
//  Created by 김수빈 on 2021/11/17.
//


import Foundation
import Alamofire

class MyPageProfileImageUploadDatamanager {
    
    func postMyPageProfileImageUpload(imageData: UIImage?, vc: MyPageWorkerSelectProfileImageVC) {
        
        let url = "\(Constant.BASE_URL)/mypage/profile/image"
        
        let header: HTTPHeaders = [ "Content-Type" : "multipart/form-data",
                                     "token":"\(UserDefaults.standard.string(forKey: "token")!)"]
        /*
        let resizedImage = resizeImage(image: imageData, newWidth: 300)
                
                let imageData = resizedImage.jpegData(compressionQuality: 0.5)
*/
        AF.upload(
                    
                    multipartFormData: { MultipartFormData in
                        if((imageData) != nil){
                            if let image = imageData?.pngData() {
                                MultipartFormData.append(image, withName: "uploadImage", fileName: "profileImage.png", mimeType: "image/png")
                            }
                           
                        }
         
                }, to: url, method: .post, headers: header).validate()
            .responseDecodable(of: MyPageProfileImageDefaultResponse.self) { response in
                switch response.result {
                
                case .success(let response):
                    // 성공했을 때
                    switch response.code {
                    case "200":
                        vc.didSuccessMyPageProfileImageUpload(result: response)
                        break
                    default:
                        vc.failedToRequestMyPageProfileImageUpload(message: response.message!)
                        break
                }
                case .failure(let error):
                    print(error.localizedDescription)
                    vc.failedToRequestMyPageProfileImageUpload(message: "서버와의 연결이 원활하지 않습니다")
                }
         
            }
    }
    func postMyPageProfileImageUpload(imageData: UIImage?, vc: MyPageManagerSelectProfileImageVC) {
        
        let url = "\(Constant.BASE_URL)/mypage/profile/image"
        
        let header: HTTPHeaders = [ "Content-Type" : "multipart/form-data",
                                     "token":"\(UserDefaults.standard.string(forKey: "token")!)"]
        /*
        let resizedImage = resizeImage(image: imageData, newWidth: 300)
                
                let imageData = resizedImage.jpegData(compressionQuality: 0.5)
*/
        AF.upload(
                    
                    multipartFormData: { MultipartFormData in
                        if((imageData) != nil){
                            if let image = imageData?.pngData() {
                                MultipartFormData.append(image, withName: "uploadImage", fileName: "profileImage.png", mimeType: "image/png")
                            }
                           
                        }
         
                }, to: url, method: .post, headers: header).validate()
            .responseDecodable(of: MyPageProfileImageDefaultResponse.self) { response in
                switch response.result {
                
                case .success(let response):
                    // 성공했을 때
                    switch response.code {
                    case "200":
                        vc.didSuccessMyPageProfileImageUpload(result: response)
                        break
                    default:
                        vc.failedToRequestMyPageProfileImageUpload(message: response.message!)
                        break
                }
                case .failure(let error):
                    print(error.localizedDescription)
                    vc.failedToRequestMyPageProfileImageUpload(message: "서버와의 연결이 원활하지 않습니다")
                }
         
            }
    }
}
