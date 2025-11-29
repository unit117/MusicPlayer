//
//  MusicPlayer+Async.swift
//  LyricsX - https://github.com/ddddxxx/LyricsX
//
//  This Source Code Form is subject to the terms of the Mozilla Public
//  License, v. 2.0. If a copy of the MPL was not distributed with this
//  file, You can obtain one at https://mozilla.org/MPL/2.0/.
//

#if canImport(Combine)

import Foundation
import Combine

// MARK: - Async/Await Extensions for MusicPlayer

@available(macOS 12.0, iOS 15.0, *)
public extension MusicPlayerProtocol {
    
    /// Stream of playback state changes
    var playbackStateStream: AsyncStream<PlaybackState> {
        AsyncStream { continuation in
            let cancellable = playbackStateWillChange
                .sink { state in
                    continuation.yield(state)
                }
            
            continuation.onTermination = { _ in
                cancellable.cancel()
            }
        }
    }
    
    /// Stream of current track changes
    var currentTrackStream: AsyncStream<MusicTrack?> {
        AsyncStream { continuation in
            let cancellable = currentTrackWillChange
                .sink { track in
                    continuation.yield(track)
                }
            
            continuation.onTermination = { _ in
                cancellable.cancel()
            }
        }
    }
}

#endif
