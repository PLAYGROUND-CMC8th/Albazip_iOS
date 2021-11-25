//
//  HomeManagerAddPublicWorkRequest.swift
//  Albazip
//
//  Created by 김수빈 on 2021/11/25.
//

import Foundation
struct HomeManagerAddPublicWorkRequest: Encodable {
    var coTaskList: [TaskLists]?
}
/*
struct TaskLists: Encodable{
    var title: String
    var content: String
}
*/
