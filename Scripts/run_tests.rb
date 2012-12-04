#!/usr/bin/env ruby

launcher_path = "ios-sim"
test_bundle_path= File.join(ENV['BUILT_PRODUCTS_DIR'], "#{ENV['PRODUCT_NAME']}.#{ENV['WRAPPER_EXTENSION']}")

environment = {
    'DYLD_INSERT_LIBRARIES' => "/../../Library/PrivateFrameworks/IDEBundleInjection.framework/IDEBundleInjection",
    'XCInjectBundle' => test_bundle_path,
    'XCInjectBundleInto' => ENV["TEST_HOST"]
}

environment_args = environment.collect { |key, value| "--setenv #{key}=\"#{value}\""}.join(" ")
app_test_host = File.dirname(ENV["TEST_HOST"])
command = "#{launcher_path} launch \"#{app_test_host}\" #{environment_args} --args -SenTest All #{test_bundle_path} 2> /tmp/test.out"
system(command)
test_output_file = File.open("/tmp/test.out")
test_output = test_output_file.read
failed = test_output.include? "failed"
print test_output;
if failed
  exit(1);
end
