//
//  CommunityManagerWriteDatamanager.swift
//  Albazip
//
//  Created by 김수빈 on 2021/11/26.
//
import Alamofire
import Foundation
class CommunityManagerWriteDatamanager {
    
    func postCommunityManagerWrite(title:String, content:String, pin: Int, imageData: [UIImage]?, vc: CommunityManagerWriteVC) {
        
        let url = "\(Constant.BASE_URL)/board/notice"
        
        let header: HTTPHeaders = [ "Content-Type" : "multipart/form-data",
                                     "token":"\(UserDefaults.standard.string(forKey: "token")!)"]
        /*
        let resizedImage = resizeImage(image: imageData, newWidth: 300)
                
                let imageData = resizedImage.jpegData(compressionQuality: 0.5)
         
         
         "title":"제목",
         "content":"내용",
         "pin":0,
        */
        let parameters: [String : Any] = [
            "title": title,
            "content": content,
            "pin": pin,
        ]
        AF.upload(
                    
                    multipartFormData: { MultipartFormData in
                        /*
                        if((imageData) != nil){
                            if let image = imageData?.pngData() {
                                MultipartFormData.append(image, withName: "images", fileName: "profileImage.png", mimeType: "image/png")
                            }
                           
                        }*/
                        for (key, value) in parameters {
                            MultipartFormData.append("\(value)".data(using: .utf8)!, withName: key)
                        }
                        
                        if let imageToUpload = imageData{
                            let count = imageToUpload.count

                                for i in 0..<count{
                                    MultipartFormData.append( imageToUpload[i].pngData()!, withName: "images", fileName: "photo\(i).png" , mimeType: "image/png")

                            }
                        }
                        
         
                }, to: url, method: .post, headers: header).validate()
            .responseDecodable(of: CommunityManagerWriteResponse.self) { response in
                switch response.result {
                
                case .success(let response):
                    // 성공했을 때
                    switch response.code {
                    case "200":
                        vc.didSuccessCommunityManagerWriteVC(result: response)
                        break
                    default:
                        vc.failedToRequestCommunityManagerWriteVC(message: response.message!)
                        break
                }
                case .failure(let error):
                    print(error.localizedDescription)
                    vc.failedToRequestCommunityManagerWriteVC(message: "서버와의 연결이 원활하지 않습니다")
                }
         
            }
    }
    
    func postCommunityManagerWriteEdit(noticeId: Int,title:String, content:String, pin: Int, imageData: [UIImage]?, vc: CommunityMangerNoticeEditVC) {
        
        let url = "\(Constant.BASE_URL)/board/notice/\(noticeId)"
        
        let header: HTTPHeaders = [ "Content-Type" : "multipart/form-data",
                                     "token":"\(UserDefaults.standard.string(forKey: "token")!)"]
        /*
        let resizedImage = resizeImage(image: imageData, newWidth: 300)
                
                let imageData = resizedImage.jpegData(compressionQuality: 0.5)
         
         
         "title":"제목",
         "content":"내용",
         "pin":0,
        */
        let parameters: [String : Any] = [
            "title": title,
            "content": content,
            "pin": pin,
        ]
        AF.upload(
                    
                    multipartFormData: { MultipartFormData in
                        /*
                        if((imageData) != nil){
                            if let image = imageData?.pngData() {
                                MultipartFormData.append(image, withName: "images", fileName: "profileImage.png", mimeType: "image/png")
                            }
                           
                        }*/
                        for (key, value) in parameters {
                            MultipartFormData.append("\(value)".data(using: .utf8)!, withName: key)
                        }
                        
                        if let imageToUpload = imageData{
                            let count = imageToUpload.count

                                for i in 0..<count{
                                    MultipartFormData.append( imageToUpload[i].pngData()!, withName: "images", fileName: "photo\(i).png" , mimeType: "image/png")

                            }
                        }
                        
         
                }, to: url, method: .put, headers: header).validate()
            .responseDecodable(of: CommunityManagerWriteResponse.self) { response in
                switch response.result {
                
                case .success(let response):
                    // 성공했을 때
                    switch response.code {
                    case "200":
                        vc.didSuccessCommunityManagerNoticeEdit(result: response)
                        break
                    default:
                        vc.failedToRequestCommunityManagerNoticeEdit(message: response.message!)
                        break
                }
                case .failure(let error):
                    print(error.localizedDescription)
                    vc.failedToRequestCommunityManagerNoticeEdit(message: "서버와의 연결이 원활하지 않습니다")
                }
         
            }
    }
}
