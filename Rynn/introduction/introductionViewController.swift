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
import YoutubePlayer_in_WKWebView

class introductionViewController: UIViewController {
    
    
    
    @IBOutlet weak var playerView: WKYTPlayerView!
    @IBOutlet weak var btnSkip: UIButton!
    @IBOutlet weak var btnBack: UIButton!
    var isBackButtonNeeded : Bool = false

    @IBOutlet weak var btnPlayAgain: UIButton!
//    @IBOutlet weak var videoView: UIView!
    //    var avPlayer: AVPlayer!
    var player: AVPlayer = AVPlayer()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        playerView.load(withVideoId: "BTR7C9mCf0s")


//        initializeVideoPlayerWithVideo()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        btnSkip.layer.cornerRadius = (btnSkip.frame.size.height / 2)
//        Singleton.sharedSingleton.setShadow(to: btnSkip)
//        AppUtility.lockOrientation(.landscapeRight)
        if (Global.appDelegate.tabBarController != nil){
            Global.appDelegate.tabBarController.hideTabBar()
        }
        if (isBackButtonNeeded){
            btnBack.isHidden = false
//            btnPlayAgain.isHidden = false
//            btnSkip.isHidden = true
        }else{
            btnBack.isHidden = true
//            btnPlayAgain.isHidden = false
//            btnSkip.isHidden = false
        }
        
//        NotificationCenter.default.addObserver(self, selector: #selector(self.didPlayToEnd), name: .AVPlayerItemDidPlayToEndTime, object: nil)

    }
    
//    @objc func didPlayToEnd() {
//         btnPlayAgain.isEnabled = true
//       btnPlayAgain.setTitle("Play Again", for: .normal)
//    }
    
    @IBAction func btnBackPressed(_ sender: Any) {
        self.navigationController?.popViewController(animated: false)
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
//        AppUtility.lockOrientation(.portrait)
    }
    

    @IBAction func btnSkipPressed(_ sender: Any) {
        let login = LoginViewController(nibName: "LoginViewController", bundle: nil)
        Global.appDelegate.navigation = UINavigationController(rootViewController: login)
        Global.appDelegate.navigation?.isNavigationBarHidden = true
        Global.appDelegate.window?.rootViewController = Global.appDelegate.navigation
        Global.appDelegate.window?.makeKeyAndVisible()
    }
    
//    @IBAction func btnPlayAgainPressed(_ sender: UIButton) {
//
//        if (player.isPlaying){
//            player.pause()
//            btnPlayAgain.setTitle("Play", for: .normal)
//        }else{
//           // initializeVideoPlayerWithVideo()
//            if (sender.titleLabel?.text == "Play Again"){
//                initializeVideoPlayerWithVideo()
//                btnPlayAgain.setTitle("Pause", for: .normal)
//            }else{
//                player.play()
//                btnPlayAgain.setTitle("Pause", for: .normal)
//            }
//
//        }
//
//    }
//    @objc func itemDidFinishPlaying(_ notification: Notification?) {
//
//        btnPlayAgain.isEnabled = true
//        btnPlayAgain.setTitle("Play", for: .normal)
////        print("DONE")
//        // Will be called when AVPlayer finishes playing playerItem
//    }

    
//    func initializeVideoPlayerWithVideo() {
//
////       btnPlayAgain.isEnabled = false
//        // get the path string for the video from assets
//        let videoString:String? = Bundle.main.path(forResource: "SampleVideo", ofType: "mp4")
//        guard let unwrappedVideoPath = videoString else {return}
//
//        // convert the path string to a url
//        let videoUrl = URL(fileURLWithPath: unwrappedVideoPath)
//
//        // initialize the video player with the url
//        self.player = AVPlayer(url: videoUrl)
//
//
//        // create a video layer for the player
//        let layer: AVPlayerLayer = AVPlayerLayer(player: player)
//
//        // make the layer the same size as the container view
//        layer.frame = self.videoView.bounds
////        layer.goFullscreen()
//
//        // make the video fill the layer as much as possible while keeping its aspect size
//        layer.videoGravity = AVLayerVideoGravity.resizeAspect
//
//        // add the layer to the container view
//
//        self.videoView.layer.addSublayer(layer)
//        player.play()
//    }
    
    
    
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


extension CGAffineTransform {
    
    static let ninetyDegreeRotation = CGAffineTransform(rotationAngle: CGFloat(M_PI / 2))
}

extension AVPlayerLayer {
    
    var fullScreenAnimationDuration: TimeInterval {
        return 0.15
    }
    
    func minimizeToFrame(_ frame: CGRect) {
        UIView.animate(withDuration: fullScreenAnimationDuration) {
            self.setAffineTransform(.identity)
            self.frame = frame
        }
    }
    
    func goFullscreen() {
        UIView.animate(withDuration: fullScreenAnimationDuration) {
            self.setAffineTransform(.ninetyDegreeRotation)
            self.frame = UIScreen.main.bounds
        }
    }
}
