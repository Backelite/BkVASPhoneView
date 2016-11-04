#
# Be sure to run `pod lib lint BkVASPhoneView.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = "BkVASPhoneView"
  s.version          = "0.1.0"
  s.summary          = "Custom view for phone number display, following the SVA+ requirements. Written in Objective-C."

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!  
  s.description      = <<-DESC
                       DESC

  s.homepage         = "https://github.com/Backelite/BkVASPhoneView"
  s.license          = 'MIT'
  s.author           = { "David Yang" => "david.yang@backelite.com" }
  s.source           = { :git => "https://github.com/Backelite/BkVASPhoneView.git", :tag => 1.0 }

  s.platform     = :ios, '7.0'
  s.requires_arc = true

  s.source_files = 'Pod/Classes/**/*'
  s.resource_bundles = {
    'BkVASPhoneView' => ['Pod/Assets/*.png', 'Pod/Classes/*.otf']
  }
end
