Pod::Spec.new do |spec|

  spec.name         = "VmaxVastHelper"
  spec.version      = "0.0.1"
  spec.summary      = "A short summary of VmaxVastHelper."
  spec.description  = "A short description of VmaxVastHelper."
  spec.homepage     = "https://www.vmax.com"
  spec.license      = "MIT"
  spec.author       = { "Cloy Vserv" => "cloy.m@vserv.com" }
  spec.platform     = :ios, "12.0"
  spec.source       = { :git => "https://git-codecommit.ap-south-1.amazonaws.com/v1/repos/vmaxng-helper-ios-vast", :tag => spec.version.to_s}
  spec.ios.deployment_target = "12.0"
  spec.vendored_frameworks = "VmaxVastHelper.xcframework"

end
