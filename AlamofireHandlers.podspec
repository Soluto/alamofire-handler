Pod::Spec.new do |s|
  s.name         = "AlamofireHandlers"
  s.version      = "1.1.0"
  s.summary      = "Better alamofire"
  s.description  = <<-DESC
  TODO: Add long description of the pod here.
                   DESC

  s.homepage     = "http://git.soluto.local/Soluto/alamofire-handler"
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.author       = { "Soluto" => "omerl@soluto.com" }

  s.platform     = :ios, "9.0"

  s.source       = { :git => 'http://git.soluto.local/Soluto/alamofire-handler.git', :tag => s.version.to_s }
  s.source_files = "AlamofireHandlers/Classes/**/*"
  s.frameworks   = ["Foundation"]

  s.dependency 'Alamofire', '~> 4.5.0'
  s.dependency 'RxSwift', '~> 3.6.0'
end