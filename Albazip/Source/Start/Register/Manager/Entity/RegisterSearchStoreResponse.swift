//
//  RegisterSearchStoreResponse.swift
//  Albazip
//
//  Created by 김수빈 on 2021/10/24.
//

struct RegisterSearchStoreResponse: Decodable {
    var documents: [RegisterSearchDocuments]
    var meta: RegisterSearchMeta
    
}

struct RegisterSearchDocuments: Decodable {
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

struct RegisterSearchMeta: Decodable {
    var is_end: Bool?
    var pageable_count: Int?
    var same_name: RegisterSearchSameName
    var total_count: Int?
}

struct RegisterSearchSameName: Decodable {
    var keyword: String?
    var region: [RegisterSearchRegion]
    var selected_region: String?
}

struct RegisterSearchRegion: Decodable {
    
}
