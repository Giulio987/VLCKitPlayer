//
//  VLCKitPlayerRapresentable.swift
//  VLCKitPlayer
//
//  Created by Giulio Milani on 29/02/24.
//

import SwiftUI
import AVKit
import AVFoundation
import MobileVLCKit

struct VideoPlayerView: UIViewRepresentable {
    @Binding var playerWrapper: VLCPlayerWrapper
    
    ///Method to create the UIKit view that is to be represented in SwiftUI
    func makeUIView(context: Context) -> UIView {
        let playerView = UIView()
        return playerView
    }
    
    ///Method to update the UIKit view that is being used in SwiftUI
    func updateUIView(_ uiView: UIView, context: Context) {
        if let player = playerWrapper.mediaPlayer {
            player.drawable = uiView
        }
    }
}

@Observable class VLCPlayerWrapper: NSObject {
    var mediaPlayer: VLCMediaPlayer?
    
    var isPlaying: Bool = false
    var isBuffering: Bool = false
    var videoLength: Double = 0.0
    var progress: Double = 0.0
    var remaining: Double = 0.0
   // var duration:
    
    override init() {
        super.init()
        mediaPlayer = VLCMediaPlayer(options: ["--network-caching=5000"]) // change your media player related options
        mediaPlayer?.delegate = self
    }
    
    ///Method to begin playing the specified URL
    func play(url: URL) {
        let media = VLCMedia(url: url)
        mediaPlayer?.media = media
        mediaPlayer?.play()
    }
    
    ///Method to stop playing the currently playing video
    func stop() {
        mediaPlayer?.stop()
        isPlaying = false
    }

    func pause() {
        if isPlaying && (mediaPlayer?.canPause ?? false) {
           mediaPlayer?.pause()
           isPlaying = false
        } else {
           mediaPlayer?.play()
           isPlaying = true
        }
    }
    
    func moveTo(position: Double) {
        if mediaPlayer?.isSeekable ?? false {
            mediaPlayer?.time = VLCTime(int: Int32(position))
        }
    }
}

extension VLCPlayerWrapper: VLCMediaPlayerDelegate {
    ///Implementation for VLCMediaPlayerDelegate to handle media player state change
    func mediaPlayerStateChanged(_ aNotification: Notification) {
        if let player = mediaPlayer {
            if player.state == .stopped {
                isPlaying = false
                isBuffering = false
            } else if player.state == .playing {
                isPlaying = true
                isBuffering = false
                videoLength = Double(mediaPlayer?.media.length.intValue ?? Int32(0.0))
            } else if player.state == .opening {
                isBuffering = true
            } else if player.state == .error {
                stop()
            } else if player.state == .buffering {
            } else if player.state == .paused {
                isPlaying = false
            }
        }
    }
    
    func mediaPlayerTimeChanged(_ aNotification: Notification!) {
        progress = Double(mediaPlayer?.time.intValue ?? Int32(0.0))
        remaining = Double(mediaPlayer?.remainingTime.intValue ?? Int32(0.0))
        //print(progress, remaining, videoLength)
    }
}

