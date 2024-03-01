//
//  VLCKitPlayer-ViewModel.swift
//  VLCKitPlayer
//
//  Created by Giulio Milani on 29/02/24.
//

import SwiftUI

extension VLCKitPlayer {
    @Observable final class ViewModel {
        var showControllers: Bool = false
        var editing: Bool = false
        var timer: Timer? = nil
    }
}
