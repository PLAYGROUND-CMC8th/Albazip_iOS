//
//  String.swift
//  EduTemplate - storyboard
//
//  Created by Zero Yoon on 2022/02/23.
//

import UIKit

extension String {
    // MARK: 자주 사용되는 기능들
    // ex. guard let email = emailTextField.text?.trim, email.isExists else { return }
    var isEmpty: Bool {
        return self.count == 0
    }
    var isExists: Bool {
        return self.count > 0
    }
    var trim: String? {
        return self.trimmingCharacters(in: .whitespacesAndNewlines)
    }
    
    
    // MARK: 다국어 지원 (localization)
    var localized: String {
        return NSLocalizedString(self, comment: "")
    }
    func localized(with values: String...) -> String {
        return String(format: NSLocalizedString(self, comment: ""), values)
    }
    
    
    // MARK: substring
    func substring(from: Int, to: Int) -> String {
        guard (to >= 0) && (from <= self.count) && (from <= to) else {
            return ""
        }
        let start = index(startIndex, offsetBy: max(from, 0))
        let end = index(start, offsetBy: min(to, self.count) - from)
        return String(self[start ..< end])
    }
    
    func substring(range: Range<Int>) -> String {
        return substring(from: range.lowerBound, to: range.upperBound)
    }
    
    
    // MARK: indexing
    func get(_ index: Int) -> String {
        return self.substring(range: index..<index)
    }
    
    
    // MARK: replace
    func replace(target: String, with withString: String) -> String{
        return self.replacingOccurrences(of: target, with: withString, options: .literal, range: nil)
    }
    
    
    // MARK: comma
    // ex. "1234567890".insertComma == "1,234,567,890"
    var insertComma: String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        if let _ = self.range(of: ".") {
            let numberArray = self.components(separatedBy: ".")
            if numberArray.count == 1 {
                var numberString = numberArray[0]
                if numberString.isEmpty {
                    numberString = "0"
                }
                guard let doubleValue = Double(numberString)
                    else { return self }
                return numberFormatter.string(from: NSNumber(value: doubleValue)) ?? self
            } else if numberArray.count == 2 {
                var numberString = numberArray[0]
                if numberString.isEmpty {
                    numberString = "0"
                }
                guard let doubleValue = Double(numberString)
                    else {
                        return self
                }
                return (numberFormatter.string(from: NSNumber(value: doubleValue)) ?? numberString) + ".\(numberArray[1])"
            }
        }
        else {
            guard let doubleValue = Double(self)
                else {
                    return self
            }
            return numberFormatter.string(from: NSNumber(value: doubleValue)) ?? self
        }
        return self
    }
    
    var insertPhone: String{
        var PHONE:String = self

        let index1 = PHONE.index(PHONE.startIndex, offsetBy: 3)
        let index2 = PHONE.index(PHONE.startIndex, offsetBy: 7)

        PHONE.insert("-", at: index2)
        PHONE.insert("-", at: index1)

        return PHONE
    }
    
    var insertDate: String{
        let date = self.substring(from: 0, to: 10)
        print(date)
        let date2 = date.replace(target: "-", with: ". ")
        return date2
    }
    var insertTime: String{
        let time = self.substring(from: 0, to: 2)
        let time2 = self.substring(from: 2, to: 4)
        return time + ":" + time2
    }
    
    var insertWorkTime: String{
        var time = self.substring(from: 0, to: 2)
        if time.substring(from: 0, to: 1) == "0"{
            time = time.substring(from: 1, to: 2)
        }
        var time2 = self.substring(from: 2, to: 4)
        if time2.substring(from: 0, to: 1) == "0"{
            time2 = time2.substring(from: 1, to: 2)
        }
        
        if time2 == "0"{
            return "(총 \(time)시간)"
        }else{
            return "(총 \(time)시간 \(time2)분)"
        }
        
    }
    //현재 날짜 구하기
    func stringFromDate() -> String {
            let now = Date()
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = self
            dateFormatter.locale = Locale(identifier: "ko_KR")
            return dateFormatter.string(from: now)
    }
    //print("yyyy-MM-dd HH:mm:ss".stringFromDate())
    
}
