Pod::Spec.new do |s|
  s.name         = "MMPulseView"
  s.version      = "1.0"
  s.summary      = "A simple view to show circle pulse repeatly."
  s.homepage     = "https://github.com/adad184/MMPulseView"
  s.license      = { :type => 'MIT License', :file => 'LICENSE' }
  s.author       = { "adad184" => "adad184@gmail.com" }
  s.source       = { :git => "https://github.com/adad184/MMPulseView.git", :tag => "1.0" }
  s.platform     = :ios, '7.0'
  s.source_files = 'Classes/*.{h,m}'
  s.requires_arc = true
end
