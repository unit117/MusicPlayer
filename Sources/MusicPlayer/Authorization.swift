//
//  MusicPlayer.swift
//  LyricsX - https://github.com/ddddxxx/LyricsX
//
//  This Source Code Form is subject to the terms of the Mozilla Public
//  License, v. 2.0. If a copy of the MPL was not distributed with this
//  file, You can obtain one at https://mozilla.org/MPL/2.0/.
//

#if canImport(Combine)
import Combine
#endif

public protocol MusicPlayerAuthorization: AnyObject {
    
    var isAuthorized: Bool { get }
    #if canImport(Combine)
    var authorizationStatusWillChange: AnyPublisher<Bool, Never> { get }
    #endif
    
    func requestAuthorizationIfNeeded()
}
