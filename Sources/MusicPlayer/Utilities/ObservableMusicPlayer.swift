//
//  ObservableMusicPlayer.swift
//  LyricsX - https://github.com/ddddxxx/LyricsX
//
//  This Source Code Form is subject to the terms of the Mozilla Public
//  License, v. 2.0. If a copy of the MPL was not distributed with this
//  file, You can obtain one at https://mozilla.org/MPL/2.0/.
//

#if canImport(Combine)

import Foundation
import Combine

/// An Observable wrapper around MusicPlayer for SwiftUI integration
@available(macOS 14.0, iOS 17.0, *)
@Observable
public final class ObservableMusicPlayer {
    
    public private(set) var currentTrack: MusicTrack?
    public private(set) var playbackState: PlaybackState = .stopped
    public private(set) var playbackTime: TimeInterval = 0
    
    private var player: (any MusicPlayerProtocol)?
    private var cancellables = Set<AnyCancellable>()
    
    public init(player: (any MusicPlayerProtocol)? = nil) {
        self.player = player
        setupBindings()
    }
    
    public func setPlayer(_ player: (any MusicPlayerProtocol)?) {
        self.player = player
        cancellables.removeAll()
        setupBindings()
    }
    
    private func setupBindings() {
        guard let player = player else {
            currentTrack = nil
            playbackState = .stopped
            playbackTime = 0
            return
        }
        
        currentTrack = player.currentTrack
        playbackState = player.playbackState
        playbackTime = player.playbackTime
        
        player.currentTrackWillChange
            .receive(on: DispatchQueue.main)
            .sink { [weak self] track in
                self?.currentTrack = track
            }
            .store(in: &cancellables)
        
        player.playbackStateWillChange
            .receive(on: DispatchQueue.main)
            .sink { [weak self] state in
                self?.playbackState = state
            }
            .store(in: &cancellables)
    }
    
    // MARK: - Player Controls
    
    public func play() {
        player?.resume()
    }
    
    public func pause() {
        player?.pause()
    }
    
    public func playPause() {
        player?.playPause()
    }
    
    public func skipToNextItem() {
        player?.skipToNextItem()
    }
    
    public func skipToPreviousItem() {
        player?.skipToPreviousItem()
    }
}

#endif
