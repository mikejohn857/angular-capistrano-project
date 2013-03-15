desc 'Execute remote commands'
task :console do
  stage = fetch(:stage)
  puts I18n.t('console.welcome', scope: :capistrano, stage: stage)
  loop do
    print "#{stage}> "
    command = $stdin.gets.chomp
    if %w{quit exit q}.include? command
      puts t('console.bye')
      break
    else
      begin
        on all do
          execute command
        end
      rescue => e
        puts e
      end
    end
  end
end
