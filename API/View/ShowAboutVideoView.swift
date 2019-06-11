//
//  ShowAboutVideoView.swift
//  API
//
//  Created by Daniil G on 10/06/2019.
//  Copyright © 2019 Daniil G. All rights reserved.
//

import UIKit

class ShowAboutVideoView: UIViewController {
    
   
    @IBOutlet var titleVideo: UILabel!
    @IBOutlet var durationVideo: UILabel!
    @IBOutlet var viewCountVideo: UILabel!
    @IBOutlet var likeCountVideo: UILabel!
    @IBOutlet var dislikeCountVideo: UILabel!
    @IBOutlet var commentCountVideo: UILabel!
    @IBOutlet var imageVideo: UIImageView!
    
    var videoOptionsController: VideoOptionsController = VideoOptionsController()
    var videoModel: VideoModel!
    var indexPath = 0
    var videoID = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(ShowAboutVideoView.touchImage))
        self.imageVideo.addGestureRecognizer(tap)
        self.imageVideo.isUserInteractionEnabled = true
        
        videoOptionsController.getRequest(id: videoID, completion: {
            DispatchQueue.main.async {
                self.reloadOptionsView()
            }
        })
    }
    
    @objc func touchImage() {
        self.performSegue(withIdentifier: "ShowVideo", sender: self)
    }
    
    func reloadOptionsView() {
        self.imageVideo.image = self.videoOptionsController.setViewImage()
        self.titleVideo.text = "Канал: \(self.videoOptionsController.setChannelTitle())"
        self.viewCountVideo.text = "Просмотров: \(self.videoOptionsController.setViewCount())"
        self.likeCountVideo.text = "Лайков: \(self.videoOptionsController.setLikeCount())"
        self.dislikeCountVideo.text = "Дизлайков: \(self.videoOptionsController.setDislikeCount())"
        self.commentCountVideo.text = "Комментариев: \(self.videoOptionsController.setComment())"
        self.durationVideo.text = "Продолжительность: \(self.videoOptionsController.getYoutubeFormattedDuration(duration: self.videoOptionsController.setDuration()))"
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let showVideo = segue.destination as? ShowVideoView {
            showVideo.videoURL = self.videoOptionsController.setURL()
        }
    }
}
