//
//  Video.swift
//  API
//
//  Created by Daniil G on 07/06/2019.
//  Copyright © 2019 Daniil G. All rights reserved.
//

import UIKit

struct Video {
    var title: String
    var description: String
    var link: String
    var image: UIImage
    var id: String
    var channelTitle: String
}

struct VideiOptions {
    var duration: String //
    var viewCount: String //
    var likeCount: String //
    var dislikeCount: String //
    var commentCount: String //
    var channelTitle: String
    var image: UIImage
    var url: String
}


struct STStatistics: Decodable {
    let viewCount: String
    let likeCount: String?
    let dislikeCount: String?
    let commentCount: String?
}

struct STContentDetails: Decodable {
    let duration: String
}

struct YTPageInfo: Decodable {
    let resultsPerPage: Int
    let totalResults: Int
}
struct YTPLResponse: Decodable {
    let etag: String
    let kind: String
    let pageInfo: YTPageInfo
    let nextPageToken: String?
    let prevPageToken: String?
}
struct YTSearchResponse: Decodable {
    let etag: String
    let kind: String
    let pageInfo: YTPageInfo
    let nextPageToken: String?
    let prevPageToken: String?
    let items: [YTVideo]
}
struct YTPLItemsResponse: Decodable {
    let etag: String
    let kind: String
    let pageInfo: YTPageInfo
    let nextPageToken: String?
    let prevPageToken: String?
    let items: [YTPLVideo]
}
struct YTStatsResponse: Decodable {
    let etag: String
    let kind: String
    let pageInfo: YTPageInfo
    let items: [YTStatistics]
}
struct YTStatistics: Decodable {
    let statistics: STStatistics
    let contentDetails: STContentDetails
    let snippet: YTSnippet
    let id: String
}
struct YTChannel: Decodable {
    
}
struct YTPlayList: Decodable {
    let kind: String
    let etag: String
    let id: String
    let snippet: YTSnippet
    let contentDetails: YTContentDetails?
}
struct YTSnippet: Decodable {
    let publishedAt: String
    let channelId: String
    let playlistId: String?
    let title: String
    let description: String
    let channelTitle: String
    let thumbnails: YTThumbnails
    let resourceId: YTResourceId?
    let position: Int?
}
struct YTThumbnails: Decodable {
    let medium: YTThumbnail
    let high: YTThumbnail
    let standard: YTThumbnail?
    let maxres: YTThumbnail?
}
struct YTThumbnail: Decodable {
    let url: String
    let width: Int?
    let height: Int?
}
struct YTPLVideo: Decodable {
    let snippet: YTSnippet
}
struct YTResourceId: Decodable {
    let kind: String
    let videoId: String
}
struct YTVideo: Decodable {
    let snippet: YTSnippet
    let id: YTid?
    let contentDetails: YTContentDetails?
}
struct YTid: Decodable {
    let kind: String
    let videoId: String?
    let playlistId: String?
}
struct YTContentDetails: Decodable {
    let itemCount: Int?
    let videoId: String?
    let videoPublishedAt: String?
}



