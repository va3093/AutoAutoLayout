# AutoAutoLayout

[![CI Status](http://img.shields.io/travis/Wilhelm/AutoAutoLayout.svg?style=flat)](https://travis-ci.org/Wilhelm/AutoAutoLayout)
[![Version](https://img.shields.io/cocoapods/v/AutoAutoLayout.svg?style=flat)](http://cocoapods.org/pods/AutoAutoLayout)
[![License](https://img.shields.io/cocoapods/l/AutoAutoLayout.svg?style=flat)](http://cocoapods.org/pods/AutoAutoLayout)
[![Platform](https://img.shields.io/cocoapods/p/AutoAutoLayout.svg?style=flat)](http://cocoapods.org/pods/AutoAutoLayout)

##Why AutoAutoLayout was built

The root cause for the development of this tool was problems that using Storyboards and AutoLayout introduce. 

For simple projects with simple UI and UX, storyboards are perfect. They can be thrown together quickly and allow for quick feedback to design changes. It also allows you to make customisations to elements on the storyboards with the use of `IBOutlets` and `IBActions`. However as a project grows and the UI becomes more complex your storyboards can introduce bad practices like showing and hiding elements based on some state. They can also become misleading because a glance at a storyboard doesn't illustrate the different states a view can have and as a result give emphasis to one particular state and makes the others difficult to change. 

So if you go full circle and move your view layout code into your source files you end up with methods like this (and much worse in some cases :grimacing:)
![Screenshot of update constraints method](ReadmeAssets/constraints.png?raw=true)

The final nail in the coffin is if you require animation. To do animations require keeping reference to the appropriate constraints and doing the UIView.animationwithduration dance remembering all the [caveats](http://stackoverflow.com/questions/18363399/autolayout-animation-issue). The advantages of using Autolayout all of sudden start to feel not worth the hassle. 

__This tool tries to put the auto back into AutoLayout__

## Requirements

- iOS 7.0
- Xcode 7

##Integration

####CocoaPods (iOS 8+, OS X 10.9+)
You can use [Cocoapods](http://cocoapods.org/) to install `SwiftyJSON`by adding it to your `Podfile`:
```ruby
platform :ios, '8.0'
use_frameworks!

target 'MyApp' do
	pod 'AutoAutoLayout', :git => 'https://github.com/va3093/autoautolayout.git'
end
```
Note that this requires CocoaPods version 36, and your iOS deployment target to be at least 8.0:


####Manually (iOS 7+, OS X 10.9+)

To use this library in your project manually you may:  

1. for Projects, just drag AutoAutoLayout.swift to the project tree

## Usage

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Author

Wilhelm, va3093@gmail.com

## License

AutoAutoLayout is available under the MIT license. See the LICENSE file for more info.
