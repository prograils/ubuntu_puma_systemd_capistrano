set :stage, :production # this defines production stage for deployment

set :branch, 'master'

role :app, %w(myapp51@myapp51.prograils.com)
role :web, %w(myapp51@myapp51.prograils.com)
role :db,  %w(myapp51@myapp51.prograils.com)
