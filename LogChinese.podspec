#
# Be sure to run `pod lib lint LogChinese.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'LogChinese'
  s.version          = '1.0.4'
  s.summary          = '显示数组里的中文'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
用以解决控制台日志输出中文，显示乱码的问题
                       DESC

  s.homepage         = 'https://gitee.com/ylx12138/LogChinese'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { '1223343444@qq.com' => '1223343444@qq.com' }
  s.source           = { :git => 'https://github.com/YueLiXing/LogChinese.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '8.0'

  s.source_files = 'LogChinese/**/*'
  
  # s.resource_bundles = {
  #   'LogChinese' => ['LogChinese/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
