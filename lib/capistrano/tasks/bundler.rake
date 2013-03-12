namespace :deploy do

  after :update, :bundle do
    on all do
      as deploy_user do
        within release_path do
          execute :bundle, "--gemfile #{release_path}/Gemfile --deployment --binstubs #{shared_path}/bin --path #{shared_path}/bundle --without development test cucumber"
        end
      end
    end
  end
end
