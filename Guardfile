guard :minitest, spring: true do
  watch(%r{^app/(.+)\.rb$})                          { |match| "test/#{match[1]}_test.rb" }
  watch('app/controllers/application_controller.rb') { 'test/controllers' }
  watch(%r{^test/.+_test\.rb$})
  watch('test/test_helper.rb')                       { 'test' }
end
