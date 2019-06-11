//
//  VideoController.swift
//  API
//
//  Created by Daniil G on 07/06/2019.
//  Copyright © 2019 Daniil G. All rights reserved.
//

import UIKit

final class VideoController {
    var api: APIModel = APIModel()
    let videoModel = VideoModel()
    var mainView: MainView!
    
    func getRequest(search: String, completion: @escaping () -> ()){
        let urlString = "https://www.googleapis.com/youtube/v3/search?part=snippet&q=\(search)&type=video&maxResults=10&regionCode=RU&key=\(self.api.apiKey)"
        
        guard let url = URL(string: urlString.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed)!) else {
            return
        }
        let session = URLSession.shared
            session.dataTask(with: url) { (data, response, error) in
                guard let data = data else {
                    return
                }
                do {
                    let json = try JSONDecoder().decode(YTSearchResponse.self, from: data)
                        for index in 0 ..< json.items.count {
                            self.setVideo(index: index, title: json.items[index].snippet.title, description: json.items[index].snippet.description, link: json.items[index].id!.kind, imageURL: json.items[index].snippet.thumbnails.medium.url, id: json.items[index].id!.videoId!, channelTitle: json.items[index].snippet.channelTitle)
                            print(index)
                                completion()
                        }
                    self.videoModel.startSearch = false
                } catch {
                    print(error.localizedDescription)
                }
            }.resume()
    }
    
    func setText(index: Int) -> String{
        if videoModel.videos.count != 0 {
            return videoModel.videos[index].title
        } else {
            return "No title"
        }
    }
    
    func setDescription(index: Int) -> String{
        if videoModel.videos.count != 0 {
            return videoModel.videos[index].description
        } else {
            return "No description"
        }
    }
    
    func setImage(index: Int) -> UIImage {
        if videoModel.videos.count != 0 {
            return videoModel.videos[index].image
        } else {
            return UIImage(named: "youtube")!
        }
    }
    
    func setVideo(index: Int, title: String, description: String, link: String, imageURL: String, id: String, channelTitle: String) {
        let image: UIImage = getImage(imageURL: imageURL)
        if videoModel.startSearch {
            videoModel.videos.append(Video(title: title, description: description, link: link, image: image, id: id, channelTitle: channelTitle))
        } else {
            videoModel.videos[index].title = title
            videoModel.videos[index].description = description
            videoModel.videos[index].link = link
            videoModel.videos[index].image = image
            videoModel.videos[index].id = id
            videoModel.videos[index].channelTitle = channelTitle
        }
        
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
    
    func numberOfRows() -> Int {
        return videoModel.videos.count
    }
    
    func returnVideoID(index: Int) -> String {
        return videoModel.videos[index].id
    }
}
