#
# Be sure to run `pod lib lint AlamofireHandlers.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'AlamofireHandlers'
  s.version          = '0.3.0'
  s.summary          = 'Better alamofire'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'http://git.soluto.local/Soluto/alamofire-handler'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Omer Levi Hevroni' => 'omerl@soluto.com' }
  s.source           = { :git => 'http://git.soluto.local/Soluto/alamofire-handler.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '9.0'

  s.source_files = 'AlamofireHandlers/Classes/**/*'

  # s.resource_bundles = {
  #   'AlamofireHandlers' => ['AlamofireHandlers/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  s.dependency 'Alamofire', '~> 4.0'
  s.dependency 'RxSwift', '~> 3.0.0.alpha'
end
