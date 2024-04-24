//
//  ForFocusVC.swift
//  Level Supermind - Assignment
//
//  Created by Ameya Chorghade on 24/04/24.
//

import UIKit
import AVFoundation

protocol MusicPlayerControlDelegate: AnyObject {
    func play()
    func pause()
    func updateMiniPlayerVisibility(isPlaying: Bool)
}

class musicPlayerVC: UIViewController {
    
    
    var player: AVAudioPlayer?
    var currentSong: Song?
    var isPlaying = true
    var timer: Timer?
    var isLiked = false
    weak var musicPlayerDelegate: MusicPlayerControlDelegate?
    
   
    var savedCurrentTime: TimeInterval = 0
      var savedIsPlaying: Bool = false
    
    @IBOutlet weak var playPauseButton: UIButton!
    @IBOutlet weak var slider: UISlider!
    
    @IBOutlet weak var likeImgView: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadSong()
        navigationController?.setNavigationBarHidden(true, animated: false)
        restorePlaybackState()
        play()
    }
    
    func savePlaybackState() {
           // Save current playback time and play/pause status
           savedCurrentTime = player?.currentTime ?? 0
           savedIsPlaying = isPlaying
       }
       
       func restorePlaybackState() {
           // Restore playback time and play/pause status
           player?.currentTime = savedCurrentTime
           if savedIsPlaying {
               player?.play()
           }
           isPlaying = savedIsPlaying

       }
   
    
    func loadSong() {
        let sampleSong = Song(title: "Example Song",
                              artist: "Example Artist",
                              duration: 60,
                              audioURL: Bundle.main.url(forResource: "raag-pilu-mix-full-vers", withExtension: "mp3")!)
        currentSong = sampleSong
        setupPlayer(with: sampleSong)
    }
    
//    func loadSong() {
//            // Replace "audioURL" with the URL of your audio file
//            guard let audioURL = URL(string: "https://v3.cdn.level.game/raag-pilu-mix-full-vers.mp3") else {
//                print("Invalid URL")
//                return
//            }
//            
//            // Create a Song instance with the URL
//            let sampleSong = Song(title: "Example Song",
//                                  artist: "Example Artist",
//                                  duration: 60,
//                                  audioURL: audioURL)
//            currentSong = sampleSong
//            setupPlayer(with: sampleSong)
//        }
    
//    func setupPlayer(with song: Song) {
//        do {
//            // Create AVAudioPlayer with the audio URL
//            player = try AVAudioPlayer(contentsOf: song.audioURL)
//            player?.delegate = self
//            slider.maximumValue = Float(player?.duration ?? 0)
//        } catch {
//            print("Failed to create audio player: \(error)")
//        }
//    }
    
    func play() {
          player?.play()
        playPauseButton.setImage(UIImage(systemName: "pause.fill"), for: .normal)
          musicPlayerDelegate?.updateMiniPlayerVisibility(isPlaying: true)
      }

      func pause() {
          player?.pause()
          playPauseButton.setImage(UIImage(systemName: "play.fill"), for: .normal)
//          musicPlayerDelegate?.updateMiniPlayerVisibility(isPlaying: false)
      }
    
    
    
    func setupPlayer(with song: Song) {
        do {
            player = try AVAudioPlayer(contentsOf: song.audioURL)
            player?.delegate = self
            slider.maximumValue = Float(player?.duration ?? 0)
        } catch {
            print("Failed to create audio player: \(error)")
        }
    }
    
    @IBAction func playPauseButtonTapped(_ sender: UIButton) {
        if isPlaying {
           pause()
            timer?.invalidate()
        } else {
        play()
            startSliderTimer()
        }
        isPlaying.toggle()
    }
    
    
    @IBAction func likeBtnTapped(_ sender: Any) {
        isLiked.toggle()
        updateButtonImage()
        
    }
    
    @IBAction func backBtnTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
        savePlaybackState()
    }
    
    func updateButtonImage() {
     
        if isLiked {
            likeImgView.image = UIImage(named: "favoriteSelected")
        } else {
            likeImgView.image = UIImage(named: "favorite")
        }

        }
    
    
    func startSliderTimer() {
           timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(updateSlider), userInfo: nil, repeats: true)
       }
       
       @objc func updateSlider() {
           slider.value = Float(player?.currentTime ?? 0)
       }
    
    @IBAction func sliderValueChanged(_ sender: UISlider) {
        player?.currentTime = TimeInterval(sender.value)
    }

    @IBAction func sliderTouchUpInside(_ sender: UISlider) {
        if isPlaying {
            player?.play()
        }
    }

    @IBAction func sliderTouchDown(_ sender: UISlider) {
        // Pause playback while sliding
        if isPlaying {
            player?.pause()
        }
    }
}

extension musicPlayerVC: AVAudioPlayerDelegate {
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        playPauseButton.setImage(UIImage(systemName: "play.fill"), for: .normal)
        isPlaying = false
    }
}
