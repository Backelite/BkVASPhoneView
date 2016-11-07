#
# Be sure to run `pod lib lint BkVASPhoneView.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = "BkVASPhoneView"
  s.version          = "1.0.1"
  s.summary          = "Custom view for phone number display, following the SVA+ requirements. Written in Objective-C."
  s.description      = <<-DESC
This is a custom view for phone number display, following the SVA+ requirements.
http://www.svaplus.fr/actualites-et-travaux/la-charte-signaletique-des-numeros-sva-8493689-1049.html
                       DESC

  s.homepage         = "https://github.com/Backelite/BkVASPhoneView"
  s.license          = 'MIT'
  s.author           = { "David Yang" => "david.yang@backelite.com" }
  s.source           = { :git => "https://github.com/Backelite/BkVASPhoneView.git", :tag => s.version.to_s }

  s.ios.deployment_target = '7.0'
  s.requires_arc = true

  s.resource_bundles = {
    'BkVASPhoneView' => ['Pod/Assets/*.png', 'Pod/Assets/*.otf']
  }
  
  s.default_subspec = 'ObjectiveC'
  
  s.subspec 'ObjectiveC' do |sp|
    # subspecs for users who don't want the Swift implementation
    sp.ios.deployment_target = '7.0'
    sp.source_files = 'Pod/Classes/**/*.{h,m}'
  end
  
  s.subspec 'Swift' do |sp|
    sp.ios.deployment_target = '8.0'
    sp.source_files = 'Pod/Classes/**/*{h,m,swift}'
  end
end
