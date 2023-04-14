//
//  YoutubeSearchModel.swift
//  Netflix Clone
//
//  Created by AyechanMaung on 14/04/2023.
//

import Foundation


struct YoutubeSearchModel: Codable {
    let items: [VideoItems]
}


struct VideoItems: Codable{
    let id: VideoData
}


struct VideoData: Codable {
    let kind: String
    let videoId: String
}
