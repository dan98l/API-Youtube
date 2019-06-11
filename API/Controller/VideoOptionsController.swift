//
//  VideoOptionsController.swift
//  API
//
//  Created by Daniil G on 10/06/2019.
//  Copyright © 2019 Daniil G. All rights reserved.
//

import UIKit

final class VideoOptionsController {
    var api: APIModel = APIModel()
    let videoModel = VideoModel()
    var showAboutVideoView: ShowAboutVideoView!
    
    func getRequest(id: String, completion: @escaping () -> ()) {
        let urlString = "https://www.googleapis.com/youtube/v3/videos?part=snippet,contentDetails,statistics&id=\(id)&key=\(self.api.apiKey)"

        guard let url = URL(string: urlString.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed)!) else {
            return
        }
        
        let session = URLSession.shared
        session.dataTask(with: url) { (data, response, error) in
            guard let data = data else {
            return
        }
            
        do {
            let json = try JSONDecoder().decode(YTStatsResponse.self, from: data)
            self.setVideoOptions(duration: self.getDuration(data: data),
                                 viewCount: json.items[0].statistics.viewCount,
                                 likeCount: json.items[0].statistics.likeCount!,
                                 dislikeCount: json.items[0].statistics.dislikeCount!,
                                 commentCount: json.items[0].statistics.commentCount!,
                                 channelTitle: self.getTitleChannel(data: data),
                                 image: self.getImage(imageURL: json.items[0].snippet.thumbnails.high.url), url: json.items[0].id)
            completion()
        } catch {
            print(error.localizedDescription)
        }
    }.resume()
    }
    
    func getDuration(data: Data) -> String {
        do {
            let json = try JSONDecoder().decode(YTStatsResponse.self, from: data)
            return json.items[0].contentDetails.duration
        } catch {
            print(error.localizedDescription)
        }
        return "Duration not found"
    }
    
    func getTitleChannel(data: Data) -> String {
       
            do {
                let json = try JSONDecoder().decode(YTStatsResponse.self, from: data)
                return json.items[0].snippet.channelTitle
            } catch {
                print(error.localizedDescription)
            }
         return "Title of Channel not found"
    }
    
    func getImage(imageURL: String) -> UIImage {
        do {
            let data = try Data(contentsOf: URL(string: imageURL)!)
            return UIImage(data: data)!
        } catch let error {
            print(error.localizedDescription)
        }
        return UIImage(named: "youtube")!
    }
    
    func setVideoOptions(duration: String, viewCount: String, likeCount: String, dislikeCount: String, commentCount: String, channelTitle: String, image: UIImage, url: String) {
        videoModel.videoOptions.append(VideiOptions(duration: duration,
                                                    viewCount: viewCount,
                                                    likeCount: likeCount,
                                                    dislikeCount: dislikeCount,
                                                    commentCount: commentCount,
                                                    channelTitle: channelTitle, image: image,
                                                    url: url))
    }
    
    func setDuration() -> String {
        return videoModel.videoOptions[0].duration
    }
    
    func setComment() -> String {
        return videoModel.videoOptions[0].commentCount
    }
    
    func setDislikeCount() -> String {
        return videoModel.videoOptions[0].dislikeCount
    }
    
    func setLikeCount() -> String {
        return videoModel.videoOptions[0].likeCount
    }
    
    func setViewCount() -> String {
        return videoModel.videoOptions[0].viewCount
    }
    
    func setChannelTitle() -> String {
        return  videoModel.videoOptions[0].channelTitle
    }
    
    func setViewImage() -> UIImage {
        return  videoModel.videoOptions[0].image
    }
    
    func getYoutubeFormattedDuration(duration: String) -> String {
        let formattedDuration = duration.replacingOccurrences(of: "PT", with: "").replacingOccurrences(of: "H", with: ":").replacingOccurrences(of: "M", with: ":").replacingOccurrences(of: "S", with: "")
        
        var duration = ""
        let components = formattedDuration.components(separatedBy: ":")
        for component in components {
            duration = duration.count > 0 ? duration + ":" : duration
            if component.count < 2 {
                duration += "0" + component
                continue
            }
            duration += component
        }
        return duration
    }
    
    func setURL() -> String {
        return videoModel.videoOptions[0].url
        
    }
}
