//
//  introductionViewController.swift
//  BUILD
//
//  Created by Ishan Vyas on 01/04/19.
//  Copyright © 2019 Govind Rakholiya. All rights reserved.
//

import UIKit
import UIKit
import AVFoundation
import AVKit

class introductionViewController: UIViewController {
    
    @IBOutlet weak var btnSkip: UIButton!
    @IBOutlet weak var btnBack: UIButton!
    var isBackButtonNeeded : Bool = false

    @IBOutlet weak var btnPlayAgain: UIButton!
    @IBOutlet weak var videoView: UIView!
    //    var avPlayer: AVPlayer!
    var player: AVPlayer = AVPlayer()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
//        let filepath: String? = Bundle.main.path(forResource: "SampleVideo", ofType: "mp4")
//        let fileURL = URL.init(fileURLWithPath: filepath!)
//
//
//        avPlayer = AVPlayer(url: fileURL)
//
//
//        let avPlayerController = AVPlayerViewController()
//        avPlayerController.player = avPlayer
//        avPlayerController.view.frame = CGRect(x: 50, y: 60, width: 200, height: 200)
//
//        //  hide show control
//        avPlayerController.showsPlaybackControls = false
//        // play video
//
//        avPlayerController.player?.play()
//        self.view.addSubview(avPlayerController.view)
        NotificationCenter.default.addObserver(self, selector: #selector(self.itemDidFinishPlaying(_:)), name: .AVPlayerItemDidPlayToEndTime, object: player)


        initializeVideoPlayerWithVideo()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if (Global.appDelegate.tabBarController != nil){
            Global.appDelegate.tabBarController.hideTabBar()
        }
        if (isBackButtonNeeded){
            btnBack.isHidden = false
            btnPlayAgain.isHidden = true
            btnSkip.isHidden = true
        }else{
            btnBack.isHidden = true
            btnPlayAgain.isHidden = false
            btnSkip.isHidden = false
        }
    }
    
    @IBAction func btnBackPressed(_ sender: Any) {
        self.navigationController?.popViewController(animated: false)
    }
    
    

    @IBAction func btnSkipPressed(_ sender: Any) {
        let login = LoginViewController(nibName: "LoginViewController", bundle: nil)
        Global.appDelegate.navigation = UINavigationController(rootViewController: login)
        Global.appDelegate.navigation?.isNavigationBarHidden = true
        Global.appDelegate.window?.rootViewController = Global.appDelegate.navigation
        Global.appDelegate.window?.makeKeyAndVisible()
    }
    
    @IBAction func btnPlayAgainPressed(_ sender: Any) {
        if (player.isPlaying){
            player.pause()
            btnPlayAgain.setTitle("Play", for: .normal)
        }else{
           // initializeVideoPlayerWithVideo()
            player.play()
            btnPlayAgain.setTitle("Pause", for: .normal)
        }
       
    }
    @objc func itemDidFinishPlaying(_ notification: Notification?) {
//        btnPlayAgain.isEnabled = true
//        print("DONE")
        // Will be called when AVPlayer finishes playing playerItem
    }

    
    func initializeVideoPlayerWithVideo() {
       
//       btnPlayAgain.isEnabled = false
        // get the path string for the video from assets
        let videoString:String? = Bundle.main.path(forResource: "SampleVideo", ofType: "mp4")
        guard let unwrappedVideoPath = videoString else {return}
        
        // convert the path string to a url
        let videoUrl = URL(fileURLWithPath: unwrappedVideoPath)
        
        // initialize the video player with the url
        self.player = AVPlayer(url: videoUrl)
        
        // create a video layer for the player
        let layer: AVPlayerLayer = AVPlayerLayer(player: player)
        
        // make the layer the same size as the container view
        layer.frame = self.videoView.bounds
        
        // make the video fill the layer as much as possible while keeping its aspect size
        layer.videoGravity = AVLayerVideoGravity.resizeAspect
        
        // add the layer to the container view
        
        self.videoView.layer.addSublayer(layer)
        player.play()
    }
    
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension AVPlayer {
    var isPlaying: Bool {
        return rate != 0 && error == nil
    }
}
