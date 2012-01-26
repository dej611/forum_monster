require 'rails/generators'
require 'rails/generators/migration'

class ForumMonster::InstallGenerator < Rails::Generators::Base
  include Rails::Generators::Migration
  
  desc "Installs the ForumMonster Controllers, Models, Views, and Migrations."
  
  argument :user_model, :type => :string, :required => false, :default => "User", :desc => "Your user model name."
  
  attr_reader :singular_camel_case_name, :plural_camel_case_name, :singular_lower_case_name, :plural_lower_case_name
  
  def self.source_root
    @source_root ||= File.join(File.dirname(__FILE__), 'templates')
  end
    
  def self.next_migration_number(dirname)
    if ActiveRecord::Base.timestamped_migrations
      Time.now.utc.strftime("%Y%m%d%H%M%S")
    else
      "%.3d" % (current_migration_number(dirname) + 1)
    end
  end

  def create_controllers
    template "controllers/forum_groups_controller.rb", "app/controllers/forum_groups_controller.rb"
    template "controllers/forums_controller.rb", "app/controllers/forums_controller.rb"
    template "controllers/topics_controller.rb", "app/controllers/topics_controller.rb"
    template "controllers/posts_controller.rb", "app/controllers/posts_controller.rb"
  end

  def create_models
    @singular_camel_case_name = user_model.singularize.camelize
    @plural_camel_case_name = user_model.pluralize.camelize
    @singular_lower_case_name = user_model.singularize.underscore
    @plural_lower_case_name = user_model.pluralize.underscore
  	
  	template "models/forum_group.rb", "app/models/forum_group.rb"
  	template "models/forum.rb", "app/models/forum.rb"
    template "models/topic.rb", "app/models/topic.rb"
    template "models/post.rb", "app/models/post.rb"
  end

  def create_views
    directory "views/forum_groups", "app/views/forum_groups"
    directory "views/forums", "app/views/forums"
    directory "views/topics", "app/views/topics"
    directory "views/posts", "app/views/posts"
    template  "public/stylesheets/forum-monster.css", "public/stylesheets/forum-monster.css"
    template  "public/images/ruby.png", "public/images/ruby.png"
  end

  def create_migrations
    migration_template 'migrations/forum_groups.rb', 'db/migrate/create_forum_groups_table.rb'
    migration_template 'migrations/forums.rb', 'db/migrate/create_forums_table.rb'
    migration_template 'migrations/topics.rb', 'db/migrate/create_topics_table.rb'
    migration_template 'migrations/posts.rb', 'db/migrate/create_posts_table.rb'
    migration_template 'migrations/user.rb', 'db/migrate/update_users_table.rb'
  end
  
  def create_routes
    route "resources :forum_groups, :except => [:index, :show]
  resources :forums, :except => :index do
    resources :topics, :shallow => true, :except => :index do
      resources :posts, :shallow => true, :except => [:index, :show]
    end
    root :to => 'forum_groups#index', :via => :get
  end"
  end
  
  def self.next_migration_number(path)
    unless @prev_migration_nr
      @prev_migration_nr = Time.now.utc.strftime("%Y%m%d%H%M%S").to_i
    else
      @prev_migration_nr += 1
    end
    @prev_migration_nr.to_s
  end
end