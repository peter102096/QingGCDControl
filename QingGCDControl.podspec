#
# Be sure to run `pod lib lint QingGCDControl.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'QingGCDControl'
  s.version          = '0.0.16'
  s.summary          = 'The common tools with Swift.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
This sdk is the common tools with Swift.
Like date, timezone, viewcontroller.
And it also include IQKeyboardManagerSwift and JGProgressHUD.
                       DESC

  s.homepage         = 'https://github.com/peter102096/QingGCDControl'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'peter102096' => 'peter102096@gmail.com' }
  s.source           = { :git => 'https://github.com/peter102096/QingGCDControl.git', :tag => s.version.to_s }
  s.social_media_url = 'https://github.com/peter102096'

  s.ios.deployment_target = '13.0'

  s.source_files = 'QingGCDControl/Classes/**/*'

  s.dependency 'IQKeyboardManagerSwift', '6.5.10'
  s.dependency 'JGProgressHUD', '2.2'
  s.dependency 'Alamofire', '5.6.4'
  s.dependency 'RealmSwift', '10.24.2'
  s.platform = :ios, '13.0'
  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES', 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'i386' }
  s.swift_version = "5.5"
  
  # s.resource_bundles = {
  #   'QingGCDControl' => ['QingGCDControl/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
