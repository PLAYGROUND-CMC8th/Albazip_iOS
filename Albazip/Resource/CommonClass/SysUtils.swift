//
//  SysUtils.swift
//  Albazip
//
//  Created by 김수빈 on 2022/09/07.
//

import Foundation

class SysUtils{
    // index -> 요일 변환 함수
    static func dayOfIndex(index :Int) -> String{
        switch (index){
            case 0: return "월"
            case 1 : return "화"
            case 2 : return "수"
            case 3: return "목"
            case 4 : return "금"
            case 5 : return "토"
            case 6: return "일"
            default:
            
                return ""
        }
    }
    
    // 시간차 구해주는 함수
    static func calculateTime(workHour: WorkHour) -> String{
        guard let openHour = workHour.startTime, let closeHour = workHour.endTime else {
            return "0시간"
        }
        
        let startTime = openHour.components(separatedBy: ":")
        let endTime = closeHour.components(separatedBy: ":")
        var startTotal = 0
        var endTotal = 0
        var hour = 0
        var minute = 0

        //마감시간이 오픈시간 값보다 작을 때 마감시간에 24더하고 빼주기
        if Int(startTime[0])!>Int(endTime[0])!{
            endTotal = (Int(endTime[0])! + 24) * 60 + Int(endTime[1])!
        }else if Int(startTime[0])!==Int(endTime[0])! , Int(startTime[1])!>Int(endTime[1])!{
            endTotal = (Int(endTime[0])! + 24) * 60 + Int(endTime[1])!
        }
        //오픈 시간보다 마감시간이 더 빠를때!
        else{
            endTotal = Int(endTime[0])! * 60 + Int(endTime[1])!
        }
        startTotal = Int(startTime[0])! * 60 + Int(startTime[1])!

        let diffTime = endTotal - startTotal
        hour = diffTime/60
        minute = diffTime%60

        return "\(hour)시간\(minute)분"
    }
}
