//
//  VLCKitPlayer.swift
//  VLCKitPlayer
//
//  Created by Giulio Milani on 29/02/24.
//

import SwiftUI
import MobileVLCKit

public struct VLCKitPlayer: View {
    @State private var playerWrapper: VLCPlayerWrapper = VLCPlayerWrapper()
    @State private var viewModel = ViewModel()
    @Binding var selectedUrl: String?
    @Binding var present: Bool
    
    public init(selectedUrl: Binding<String?>, present: Binding<Bool>) {
        _selectedUrl = selectedUrl
        _present = present
    }
    
    
    public var body: some View {
        ZStack(alignment: .topTrailing) {
            if selectedUrl != nil {
                VideoPlayerView(playerWrapper: $playerWrapper)
                    .onAppear {
                        if let stringUrl = selectedUrl, let url = URL(string: stringUrl) {
                            playerWrapper.play(url: url)
                        }
                    }
                    .onTapGesture {
                        if !viewModel.showControllers {
                            viewModel.timer?.invalidate()
                            viewModel.timer =  Timer.scheduledTimer(withTimeInterval: 4.0, repeats: false) { timer in
                                print(viewModel.editing)
                                if viewModel.showControllers && !viewModel.editing {
                                    withAnimation {
                                        viewModel.showControllers.toggle()
                                    }
                                }
                            }
                        }
                        withAnimation {
                            viewModel.showControllers.toggle()
                        }
                        
                    }
                    .overlay {
                        Overlay()
                    }
                if viewModel.showControllers {
                    Button {
                        playerWrapper.stop()
                        withAnimation {
                            selectedUrl = nil
                            present = false
                        }
                    } label: {
                        Image(systemName: "xmark")
                            .font(.title2)
                            .foregroundStyle(.white)
                            .padding()
                            .zIndex(15.0)
                    }
                }
            } else {
                VStack {
                    ProgressView()
                        .progressViewStyle(.circular)
                        .tint(.white)
                        .scaleEffect(1.5)
                }.frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
                
            }
        }
        .padding()
        .padding(.vertical, 16)
        .background(.black)
        .ignoresSafeArea()
    }
    
    @ViewBuilder private func Overlay() -> some View {
        if viewModel.showControllers && playerWrapper.mediaPlayer != nil  {
            VStack {
                Spacer()
                Button {
                    playerWrapper.pause()
                } label: {
                    Image(systemName: "play.fill")
                        .font(.title)
                        .scaleEffect(1.4)
                }
                Spacer()
                if playerWrapper.videoLength > 0.0 {
                    Slider(value: $playerWrapper.progress,
                           in: 0.0...playerWrapper.videoLength,
                           step: 0.5) { editing in
                        viewModel.editing = editing
                        if editing {
                            if playerWrapper.mediaPlayer  != nil {
                                playerWrapper.pause()
                            }
                        } else {
                            playerWrapper.moveTo(position: playerWrapper.progress)
                            playerWrapper.pause()
                            if viewModel.showControllers {
                                Timer.scheduledTimer(withTimeInterval: 2.0, repeats: false) { timer in
                                    withAnimation {
                                        viewModel.showControllers.toggle()
                                    }
                                }
                            }
                        }
                    }
                    
                    HStack {
                        Text("\(VLCTime(int: Int32(playerWrapper.progress)))")
                        Spacer()
                        Text("\(VLCTime(int: Int32(playerWrapper.remaining)))")
                    }
                }
                
            }
            .zIndex(2.0)
            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
            .foregroundStyle(.white)
            .background(.black.opacity(0.4))
            .onTapGesture {
                withAnimation {
                    viewModel.showControllers.toggle()
                }
            }
        }
        
    }
}

#Preview {
    VLCKitPlayer(selectedUrl: .constant(nil), present: .constant(true))
}
