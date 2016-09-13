use_frameworks!

# TODO: Remove this after all pods are converted to swift 3
def swift3_overrides
    pod 'Validation', :git => 'https://github.com/nextforce/Validation.git', :branch => 'swift-3'
end

target 'Tests' do
  swift3_overrides
  pod 'InputValidator', path: "."
end
