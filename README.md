# BkVASPhoneView
=========
[![License MIT](https://img.shields.io/badge/license-MIT-green.svg)](https://github.com/Backelite/BkVASPhoneView/blob/master/LICENSE)
[![Release](http://img.shields.io/github/release/Backelite/BkVASPhoneView.svg)](https://github.com/Backelite/BkVASPhoneView)
[![CocoaPods Compatible](https://img.shields.io/cocoapods/v/BkVASPhoneView.svg)](https://img.shields.io/cocoapods/v/BkVASPhoneView.svg)

Custom view for phone number display, following the SVA+ requirements. Written in Objective-C.

![Image](assets/overview.png)

## XIB

BkVASPhoneView is IBDesignable/IBInspectable compliant. Simply drag and drop a UIView on your storyboard/XIB, change the class to "BkVASPhoneView" and you can customize the phone number, type/color and fee display.

![IB-Usage](assets/ib-usage.gif)

BkVASPhoneView works great with Auto-Layout : juste like a regular UILabel, by not setting a specific width and height, its size will not exceed the size it requires.

Please note that **IBDesignable feature is not available through a Carthage installation**. Please see [#335](https://github.com/Carthage/Carthage/issues/335) for more information.

## Programmatically

To instantiate a BkVASPhoneView :

Objective-C :
```Objective-C
BkVASPhoneView *phoneView = [[BkVASPhoneView alloc] initWithPhoneNumber:@"0 825 123 456" feeType:BkVASFeeTypePremium fee:@"0,34€/min" size:BkVASPhoneSizeSmall];
[self.view addSubview:phoneView];
```

Swift :
```Swift
let phoneView = VASPhoneView(phoneNumber: "0 802 12 12", feeType: .premium, fee: "0,34€/min", size: .small)
self.view.addSubview(phoneView)
```

To re-use an instance of BkVASPhoneView and configure it with new informations :

Objective-C :
```Objective-C
[phoneView configureWithPhoneNumber:@"0 825 123 456" feeType:BkVASFeeTypePremium fee:@"0,34€/min" size:BkVASPhoneSizeSmall];
```

Swift :
```Swift
phoneView.configure(phoneNumber: "0 802 12 12", feeType: .premium, fee: "0,34€/min", size: .small)
```

## Usage

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Installation

### From CocoaPods

BkVASPhoneView is available through [CocoaPods](http://cocoapods.org). To install it, simply add the following line to your Podfile:

```ruby
pod "BkVASPhoneView"
```

For Swift projects (includes Swift aliases for classes and enums) :

```ruby
pod "BkVASPhoneView/Swift"
```

### From Carthage

```ogdl
github "Backelite/BkVASPhoneView"
```

Run `carthage update` to build the framework and drag the built `BkVASPhoneView.framework` (along with `BkVASPhoneViewSwift.framework` for Swift projects) (in Carthage/Build/iOS folder) into your Xcode project (Linked Frameworks and Libraries in `Targets`).

## Requirements

iOS 7+ (through CocoaPods)
iOS 8+ (through Carthage)

## Authors

David Yang, david.yang@backelite.com

## License

BkVASPhoneView is available under the MIT license. See the LICENSE file for more info.
