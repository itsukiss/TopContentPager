Pod::Spec.new do |spec|
  spec.name           = "TopContentPager"
  spec.version        = "0.0.2"
  spec.summary        = "Pager Like Instagram Mypage View"
  spec.homepage       = "https://github.com/itsukiss/TopContentPager"
  spec.license        = { :type => 'MIT', :file => 'LICENSE' }
  spec.author         = "itsukiss"
  spec.platform       = :ios, "11.0"
  spec.swift_version  = "5.0"
  spec.source         = { :git => "https://github.com/itsukiss/TopContentPager.git", :tag => "#{spec.version}" }
  spec.source_files   = "TopContentPager/**/*.swift"
  spec.resource_bundles = { 'TopContentPager' => ['TopContentPager/**/*.{storyboard, xib}'] }
end
