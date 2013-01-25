require 'rspec/core/rake_task'

deploy_branch = :master  # :deploy will only run if in this branch

def ok_failed(condition)
  if (condition)
    puts "## OK"
  else
    puts "## FAILED"
  end
end

# Begin tasks

def in_branch?(branch)
  git_branch = %x[git rev-parse --abbrev-ref HEAD].strip.to_sym
  branch == git_branch
end

desc "Deploy to Heroku"
task :deploy do
	abort("## Not in #{deploy_branch} branch!") unless in_branch?(deploy_branch)
  ok_failed system("rsync -avze 'ssh -p #{ssh_port}' #{exclude} #{rsync_args} #{"--delete" unless rsync_delete == false} . #{ssh_user}:#{document_root}")
  ok_failed system("git push heroku master")
end

RSpec::Core::RakeTask.new(:spec)
task :default => :spec
