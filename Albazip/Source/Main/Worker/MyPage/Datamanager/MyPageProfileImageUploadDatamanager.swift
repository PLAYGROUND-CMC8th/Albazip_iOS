//
//  MyPageProfileImageUploadDatamanager.swift
//  Albazip
//
//  Created by 김수빈 on 2021/11/17.
//
import Alamofire
import Foundation
/*
class MyPageProfileImageUploadDatamanager{
    func requestIdentify(userName: String,
                             imgData: Data,
                             completion: @escaping (DataResponse<HttpStatusCode>) -> Void) {

            var urlComponent = URLComponents(string: BaseAPI.shared.getBaseString())
            urlComponent?.path = RequestURL.identify.getRequestURL
            let header: [String: String] = [
                "Content-Type": "multipart/form-data"
            ]
            let parameters = [
                "userName" : userName
            ]
            guard let url = urlComponent?.url else {
                return
            }

            Alamofire.upload(multipartFormData: { multipartFormData in
                for (key, value) in parameters {
                    multipartFormData.append("\(value)".data(using: .utf8)!, withName: key, mimeType: "text/plain")
                }

                multipartFormData.append(imgData, withName: "img", fileName: "\(userName).jpg", mimeType: "image/jpg")

            }, to: url, method: .post, headers: header) { result in
                switch result {
                case .success(let upload, _, _):
                    upload.responseJSON { response in
                        print(response)
                        guard let data = response.data else { return }
                        if let decodedData = try? JSONDecoder().decode(ResponseSimple<Int>.self, from: data) {
                            print(decodedData)
                            guard let httpStatusCode
                                = HttpStatusCode(rawValue: decodedData.statusCode) else {
                                    completion(.failed(NSError(domain: "status error",
                                                               code: 0,
                                                               userInfo: nil)))
                                    return
                            }
                            completion(.success(httpStatusCode))

                        } else {
                            completion(.failed(NSError(domain: "decode error",
                                                       code: 0,
                                                       userInfo: nil)))
                            return
                        }
                    }
                case .failure(let err):
                    completion(.failed(err))
                }
            }
        }
     ]
}
*/
