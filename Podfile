platform :ios, '10.0'
inhibit_all_warnings!
use_frameworks!

source 'https://github.com/CocoaPods/Specs.git'

install! 'cocoapods',
#:integrate_targets => true,
:deduplicate_targets => true

def required_pods
    use_frameworks!
    #    pod 'Fabric'
    #    pod 'Crashlytics'
end

["StarWars",
].each do |target_name|
    target target_name do
        required_pods
    end
    puts "Target: #{target_name}"
end

pre_install do |installer|
    def installer.verify_no_duplicate_framework_names; end
def installer.verify_no_static_framework_transitive_dependencies; end
end


post_install do |installer|
    #   installer.pods_project.targets.each do |target|
    #     puts "#{target.name}"
    #   end
    installer.pods_project.build_configuration_list.build_configurations.each do |configuration|
        configuration.build_settings['CLANG_ALLOW_NON_MODULAR_INCLUDES_IN_FRAMEWORK_MODULES'] = 'YES'
    end
end
