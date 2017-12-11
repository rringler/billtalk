Rake::Task['spec:features'].clear

namespace :spec do
  desc 'Run the code examples in spec/features'
  task :features, [:path] => [:environment] do |_, args|
    args.with_defaults(path: 'spec/features/*')

    sh "bundle exec rspec #{args[:path]} --tag type:feature"
  end
end
