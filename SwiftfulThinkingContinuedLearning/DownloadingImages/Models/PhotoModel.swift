//  PhotoModel.swift

import Foundation

// We conform to Codable so that we can decode the JSON data into PhotoModel data
struct PhotoModel: Identifiable, Codable {
let albumId: Int
    let id: Int
    let title: String
    let url: String
    let thumbnailUrl: String
}


/*
 {
 "albumId": 1,
 "id": 1,
 "title": "accusamus beatae ad facilis cum similique qui sunt",
 "url": "https://via.placeholder.com/600/92c952",
 "thumbnailUrl": "https://via.placeholder.com/150/92c952"
 }
 */
