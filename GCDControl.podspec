Pod::Spec.new do |s|
    s.name         = "GCDControl"
    s.version      = "0.0.1"
    s.summary      = "A Peter description of GCDControl project."
    s.description  = <<-DESC
    An extended description of GCDControl project.
    DESC
    s.homepage     = "https://github.com/peter102096/QingGCDControl"
    s.license = { :type => 'Copyright', :text => <<-LICENSE
                   Copyright 2022
                   Permission is granted to Peter.
                  LICENSE
                }
    s.author = { 'peter102096' => 'peter102096@gmail.com' }
    s.source = { :git => "https://github.com/peter102096/QingGCDControl.git", :tag => "#{s.version}" }
    s.source_files = "GCDControl/**/*.swift"
    s.resources = "GCDControl/**/*.xib"
    s.dependency 'IQKeyboardManagerSwift'
    s.dependency 'JGProgressHUD'

    s.platform = :ios, '13.0'

    s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES', 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'i386' }
    s.swift_version = "5.5"
end
