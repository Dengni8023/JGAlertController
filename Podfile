source 'https://github.com/CocoaPods/Specs.git'

inhibit_all_warnings!
# iOS 8使用动态framework
use_frameworks!

# workspace
workspace "JGAlertController"

# platform
platform :ios, '8.0'

# JGAlertController
target "JGAlertController" do
    
    # JGSourceBase
    pod 'JGSourceBase', "~> 0.0.2"
    
    # project
    project "JGAlertController.xcodeproj"
end

# Demo中必须保留，即使内部无任何Pod依赖，否则Demo中无法使用JGAlertController依赖的Pod库
# JGAlertControllerDemo
target "JGAlertControllerDemo" do
    
    # project
    project "JGAlertController.xcodeproj"
end

