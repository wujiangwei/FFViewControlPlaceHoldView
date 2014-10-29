Pod::Spec.new do |spec|
spec.name         = 'FFViewControlPlaceHoldView'
spec.license      = { :type => 'MIT' }
spec.platform     = :ios, '6.0'
spec.homepage     = 'https://github.com/wujiangwei/FFViewControlPlaceHoldView'
spec.authors      = 'Kevin.Wu'
spec.summary      = 'FFViewControlPlaceHoldView'
spec.source       =  {:git => 'https://github.com/wujiangwei/FFViewControlPlaceHoldView.git'}
spec.source_files = '{UIViewController+FFViewControllerPlaceholdHelper}{FFVCPlaceholdView}.{h,m}'
spec.frameworks = 'Foundation'
spec.dependency 'MBProgressHUD'
spec.ios.deployment_target = '6.0'
spec.requires_arc = true
end
