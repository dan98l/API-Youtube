//
//  MainView.swift
//  API
//
//  Created by Daniil G on 07/06/2019.
//  Copyright © 2019 Daniil G. All rights reserved.
//

import UIKit

class MainView: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var videoController: VideoController = VideoController()
    var videoModel: VideoModel!
    var indexPathForSegue = 0
    
    @IBOutlet var progressView: UIProgressView!
    @IBOutlet var tableView: UITableView!
    @IBOutlet var inputSearchText: UITextField!
    
    @IBAction func searchButton(_ sender: Any) {
        if inputSearchText.text != "" {
            self.videoController.getRequest(search: self.inputSearchText.text!, completion: {
                DispatchQueue.main.async {
                    self.updateProgressView()
                }
            })
        }
    }
    
    func tableViewReloadData() {
          self.tableView.reloadData()
    }
    
    func updateProgressView() {
        if progressView.progress != 1 {
            print("_______________________________")
            print(progressView.progress)
            self.progressView.progress += 1/9
        } else {
            self.progressView.progress = 0
            self.tableViewReloadData()
        }
    }
    
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didWriteData bytesWritten: Int64, totalBytesWritten: Int64, totalBytesExpectedToWrite: Int64) {
        let tempProgress:Float = Float(totalBytesWritten)/Float(totalBytesExpectedToWrite)
        self.progressView.setProgress(tempProgress, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        progressView.setProgress(0, animated: false)
        
        let nib = UINib(nibName: "VideoCell", bundle: nil)
        self.tableView?.register(nib, forCellReuseIdentifier: "VideoCell")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         return videoController.numberOfRows()
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "VideoCell", for: indexPath) as? VideoCell else {
            assertionFailure("Can't dequeue cell.")
            return UITableViewCell()
        }
            cell.titleVideo.text = self.videoController.setText(index: indexPath.row)
            cell.descriptionVideo.text = self.videoController.setDescription(index: indexPath.row)
            cell.imageVideo.image = self.videoController.setImage(index: indexPath.row)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.indexPathForSegue = indexPath.row
        self.performSegue(withIdentifier: "ShowAboutVideo", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let showAbout = segue.destination as? ShowAboutVideoView {
            showAbout.videoID = self.videoController.returnVideoID(index: indexPathForSegue)
            showAbout.indexPath = indexPathForSegue
        }
    }
}

