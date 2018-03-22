set :stage, :staging # this defines production stage for deployment

set :branch, 'rails52'

set :deploy_to, "/home/myapp52/app/"

role :app, %w(myapp52@myapp52.prograils.com)
role :web, %w(myapp52@myapp52.prograils.com)
role :db,  %w(myapp52@myapp52.prograils.com)
