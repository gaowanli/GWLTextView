Pod::Spec.new do |s|
  s.name             = 'GWLTextView'
  s.version          = '0.1.0'
  s.summary          = 'A short description of GWLTextView.'
  s.homepage         = 'https://github.com/gaowanli/GWLTextView'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'gaowanli' => 'im_gwl@163.com' }
  s.source           = { :git => 'https://github.com/gaowanli/GWLTextView.git', :tag => s.version.to_s }
  s.ios.deployment_target = '8.0'
  s.source_files = 'GWLTextView/Classes/**/*'   
end
