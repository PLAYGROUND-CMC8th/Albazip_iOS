//
//  SignInSearchStoreResponse.swift
//  Albazip
//
//  Created by 김수빈 on 2021/10/24.
//

struct SignInSearchStoreResponse: Decodable {
    var documents: [SignInSearchDocuments]
    var meta: SignInSearchMeta
    
}

struct SignInSearchDocuments: Decodable {
    var address_name: String?
    var category_group_code: String?
    var category_group_name: String?
    var category_name: String?
    var distance: String?
    var id: String?
    var phone: String?
    var place_name: String?
    var place_url: String?
    var road_address_name: String?
    var x: String?
    var y: String?
}

struct SignInSearchMeta: Decodable {
    var is_end: Bool?
    var pageable_count: Int?
    var same_name: SignInSearchSameName
    var total_count: Int?
}

struct SignInSearchSameName: Decodable {
    var keyword: String?
    var region: [SignInSearchRegion]
    var selected_region: String?
}

struct SignInSearchRegion: Decodable {
    
}
