# AutoAutoLayout

[![CI Status](http://img.shields.io/travis/Wilhelm/AutoAutoLayout.svg?style=flat)](https://travis-ci.org/Wilhelm/AutoAutoLayout)
[![Version](https://img.shields.io/cocoapods/v/AutoAutoLayout.svg?style=flat)](http://cocoapods.org/pods/AutoAutoLayout)
[![License](https://img.shields.io/cocoapods/l/AutoAutoLayout.svg?style=flat)](http://cocoapods.org/pods/AutoAutoLayout)
[![Platform](https://img.shields.io/cocoapods/p/AutoAutoLayout.svg?style=flat)](http://cocoapods.org/pods/AutoAutoLayout)

##Why AutoAutoLayout was built

AutoAutoLayout is a swift library that puts the auto back into AutoLayout.

1. [How it Becag](#how-it-began)
1. [Requirements](#requirements)
1. [Integration](#integration)
1. [Usage](#usage)
	- [Adding Constraints](#adding-constraints)

##How it began

For simple projects with simple UI and UX, storyboards are perfect. They can be thrown together quickly and allow for quick feedback to design changes. It also allows you to make customisations to elements on the storyboards with the use of `IBOutlets` and `IBActions`. However as a project grows and the UI becomes more complex your storyboards can introduce bad practices like showing and hiding elements based on some state. They can also become misleading because a glance at a storyboard doesn't illustrate the different states a view can have and as a result give emphasis to one particular state and makes the others difficult to change. 

So if you go full circle and move your view layout code into your source files you end up with methods like this (and much worse in some cases :grimacing:)
![Screenshot of update constraints method](ReadmeAssets/constraints.png?raw=true)

The final nail in the coffin is if you require animation. To do animations require keeping reference to the appropriate constraints and doing the UIView.animationwithduration dance remembering all the [caveats](http://stackoverflow.com/questions/18363399/autolayout-animation-issue). The advantages of using Autolayout all of sudden start to feel not worth the hassle. 

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

#### Adding Constraints

Almost all of AutoAutoLayout is built around the following method:

```swift
	public func addCustomConstraints(
        	inView superView: UIView,
        	toViews views: [UIView]? = nil,
        	selfAttributes: [NSLayoutAttribute],
        	otherViewAttributes: [NSLayoutAttribute]? = nil,
        	relations: [NSLayoutRelation]? = nil,
        	padding: [CGFloat]? = nil )
        	-> [NSLayoutConstraint] {
			//... 
		}
```
This method allows you to turn this:
```swift

```

Into this:
```swift
	self.wrapperView.addConstraints([
			NSLayoutConstraint(item: view1, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: self.wrapperView, attribute: NSLayoutAttribute.Top, multiplier: 1.0, constant: 0.0),
			NSLayoutConstraint(item: view1, attribute: NSLayoutAttribute.Leading, relatedBy: NSLayoutRelation.Equal, toItem: self.wrapperView, attribute: NSLayoutAttribute.Leading, multiplier: 1.0, constant: 0.0),
			NSLayoutConstraint(item: view1, attribute: NSLayoutAttribute.Trailing, relatedBy: NSLayoutRelation.Equal, toItem: self.wrapperView, attribute: NSLayoutAttribute.Trailing, multiplier: 1.0, constant: 0.0),
			NSLayoutConstraint(item: view1, attribute: NSLayoutAttribute.Bottom, relatedBy: NSLayoutRelation.Equal, toItem: self.wrapperView, attribute: NSLayoutAttribute.Bottom, multiplier: 1.0, constant: 0.0)

			])
```

## Author

Wilhelm, va3093@gmail.com

## License

AutoAutoLayout is available under the MIT license. See the LICENSE file for more info.
