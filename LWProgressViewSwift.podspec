#
# LWProgressViewSwift.podspec
# Swift/SwiftUI version of LWProgressView
#

Pod::Spec.new do |s|
  s.name             = 'LWProgressViewSwift'
  s.version          = '2.0.0'
  s.summary          = 'LWProgressView - Swift/SwiftUI version - Circular progress indicator component'

  s.description      = <<-DESC
LWProgressViewSwift is a modern Swift/SwiftUI rewrite of LWProgressView.
It provides a circular progress indicator with a semi-transparent overlay,
supporting both UIKit and SwiftUI integration.

Features:
- Pure Swift implementation
- SwiftUI support with native views
- UIKit compatibility layer
- No external dependencies
- Modern iOS 13+ API
                       DESC

  s.homepage         = 'https://github.com/luowei/LWProgressView'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'luowei' => 'luowei@wodedata.com' }
  s.source           = { :git => 'https://github.com/luowei/LWProgressView.git', :tag => "swift-#{s.version}" }

  s.ios.deployment_target = '13.0'
  s.swift_versions = ['5.0', '5.1', '5.2', '5.3', '5.4', '5.5', '5.6', '5.7', '5.8', '5.9']

  s.source_files = 'LWProgressView/Classes/*.swift'

  s.frameworks = 'UIKit', 'SwiftUI', 'Combine'

  # No external dependencies - pure Swift implementation
end
