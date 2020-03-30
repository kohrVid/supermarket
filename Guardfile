guard :rspec, cmd: 'rspec' do
  watch(%r{spec\/.+\.rb})
  watch(%r{(.*)\.rb}) { |m| "spec/#{m[1]}_spec.rb" }
  watch(%r{lib\/(.*)\.rb}) { |m| "spec/#{m[1]}_spec.rb" }
  watch(%r{lib\/models\/(.*)\.rb}) { |m| "spec/models/#{m[1]}_spec.rb" }
  watch(%r{lib\/presenters\/(.*)\.rb}) { |m| "spec/presenters/#{m[1]}_spec.rb" }
end
