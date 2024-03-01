<div align="center">
<p align="center">
   <h1>VLCKitPlayer</h1>
</p>
<p align="center">
    <img src="https://img.shields.io/badge/version-1.0.0-blue" />
    <img src="https://img.shields.io/badge/language-Swift-orange" />
</p>
</div>
VLCKitPlayer is a SwiftUI view component that integrates MobileVLCKit and provides a player for video streaming in your iOS app.

## Overview

If you want that your app support HLS streaming, one of the best options is to use the MobileVLCKit, which is a modular multimedia framework that enables developers to easily add video and audio playback to their iOS applications. But the library does not provide any player but only a view with the video streaming. So, to make it easier to use the MobileVLCKit, I created the VLCKitPlayer, which is a SwiftUI view component that integrates the MobileVLCKit and provides a player for video streaming in your iOS app.

## Installation and Configuration

To use VLCKitPlayer in your project, follow these steps:

### Install CocoaPods

If you haven't already, install CocoaPods by running the following command in your terminal:

```bash
sudo gem install cocoapods
```

Create a Podfile: Navigate to your project directory in the terminal and create a Podfile by running:

```bash
pod init
```

Add MobileVLCKit as dependency to Your Podfile: Open the Podfile in a text editor and you should add something like this:

```ruby
target 'YourApp' do
  use_frameworks!

  platform :ios, '8.4'
  pod 'MobileVLCKit', '~>3.3.0'
end
```

Install the dependencies: Run the following command in your terminal:

```bash
pod install
```

Open the .xcworkspace file: Close your Xcode project and open the .xcworkspace file that was created by CocoaPods.

### Add VLCKitPlayer to your project

First of all you need to download and extract the .framework file from the [releases](https://github.com/Giulio987/VLCKitPlayer/releases) section of this repository.
Make sure to extract it before proceeding.

Add the VLCKitPlayer.framework to your project:

1. From Xcode, open the project navigator and select your project.
2. Create a "Frameworks" group in your project if it not exist. (optional)
3. Right-click on the "Frameworks" group and select "Add Files to <\<YourApp>>".
4. Select the VLCKitPlayer.framework file and click "Add".
5. Verify that the framework is added to the "Link Binary With Lybraries" section in the "Build Phases" tab of your target.
6. On "General" tab of your target, verify if the framework is listed in the "Frameworks, Libraries, and Embedded Content" section.
7. If the value for this framework is "Do Not Embed", change it to "Embed & Sign" or "Embed Without Signing" (if you are only testing)

### Add VLCKitPlayer to your SwiftUI view

To add the VLCKitPlayer to your SwiftUI view, you can follow the example below:

```swift
import SwiftUI
import VLCKitPlayer

struct VLCKitTest: View {
    @State private var openFullScreenModal = false
    var body: some View {
        VStack{
            Button(action: {
                openFullScreenModal.toggle()
            }, label: {
                Text("Press Me")
            })
        }
        .fullScreenCover(isPresented: $openFullScreenModal, content: {
            VLCKitPlayer(selectedUrl: .constant("YourMp4OrHLSStreamingLink"), present: $openFullScreenModal)
        })

    }
}

#Preview {
    VLCKitTest()
}

```

## Usage

To use the VLCKitPlayer, you need to create a SwiftUI view and add the VLCKitPlayer to it. The VLCKitPlayer has two parameters:

- selectedUrl: A binding to a string that represents the URL of the video to be played.
- present: A binding to a boolean that represents if the player should be presented or not.

## Preview

Here is a preview of the VLCKitPlayer in action:

<img alt="Player in action" src="https://github.com/Giulio987/VLCKitPlayer/blob/main/Static/test.gif" width="220" height="330"/>

## Contributing

The player is not configurable yet, but I am working on it (and you can too). If you want to contribute to the project, you can fork the repository and create a pull request with your changes.
Feel free to open an issue if you have any questions or suggestions.

## Disclaimer

This project is not affiliated with the VideoLAN organization. The MobileVLCKit is a project of the VideoLAN organization. This project is just a wrapper around the MobileVLCKit to make it easier to use in SwiftUI.

## License

VLCKitPlayer is available under the MIT license. See the LICENSE file for more info.

## Author

[Giulio Milani](https://github.com/Giulio987)
