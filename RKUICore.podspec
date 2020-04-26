Pod::Spec.new do |spec|
  spec.name         = "RKUICore"
  spec.version      = "0.0.2"
  spec.summary      = "RKUICore"

  spec.description  = "RKUICore."
  spec.homepage     = "https://github.com/DaskiOFF/RKUICore"
  spec.author       = { "Roman Kotov" => "waydeveloper@gmail.com" }
  spec.platform     = :ios, "9.0"
  spec.swift_versions = "5.2"

  spec.source       = { :git => "https://github.com/DaskiOFF/RKUICore.git", :tag => "#{spec.version}" }

  spec.source_files  = "Sources", "RKUICore/**/*.{swift}"

end
