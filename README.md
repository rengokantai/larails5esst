##larails5esst

##2. Get Started
###2 Configure a project
```
create database larails5esst_development;
create database larails5esst_test;
```

create user:
```
create user 'ke'@'%' identified by 'root';
grant all privileges on *.* to 'ke'@'%' with grant option;
```

this is optional:
```
grant all privileges on larails5esst_development.* to 'ke'@'%' identified by 'pass';
grant all privileges on larails5esst_test.* to 'ke'@'%' identified by 'pass';
```
go to config/database.yml, edit password, host
```
```

dump to test mysql connection:
```
rails db:schema:dump
```
then check db/schema.rb

####7 Routes
short version and longer version
```
get "demo/index" 
```
longer
```
match "demo/index", :to=>"demo#index", :via=>:get
```
default route structure
```
:controller/:action/:id
```
for example
GET /students/edit/1->student controller,edit action,id=1  


hence
```
get ':controller(/:action("id))'

match ':controller(/:action("id))', :via=>:get
```

root route
```
root 'demo#index'   //(controller#action)
match "/", :to=>"demo#index",:via=>:get
```

###3. Controllers, Views, and Dynamic Content
####1 Render a template
in a controller,we can use relative path or absolute path
```
def index
	render('hello')  #demo/hello.html.erb
end
```

####2 Redirect actions
```
def other_hello
	redirect_to(:controller => 'demo', :action => 'index')
	redirect_to(:action => 'index')  #if same controller we can omit controller part
end
```

to external link
```
redirect_to('http://xx.com')
```

####4 Instance variables
An instance variable is this variable applies inside this instance of an object,Ex
```
def hello
	@arr=[1,2]
	render('hello')
end
```
hello.html.erb
```
<% @arr.each do |n|%>
	<%= n %>
<% end %>
```

####5 Links
html links
```
<a href="/demo/index"></a>
```
in rails
```
<%= link_to("text","/demo/index") %>
```
or long method
```
<%= link_to("text",{:controller=>'demo',:action=>'index'}) %>
```

05:10 in config/routes.rb, if
```
root 'demo#index'
get 'demo/index'
```
rails will prefer first one because router is short

####6 URL parameters
```
<%= link_to("text",{:controller=>'demo',:action=>'index',:id=>1,:para2=>10}) %>
```

controller
```
def hello
	@arr=[1,2]
	@id=params[:id]
	render('hello')
end
```

hello.html.erb
```
<%= @id %>
```
###4. Database and Migrations
####1 Introduction to database
Common terms
Row->single record of data  
field->intersection of a column and row  
index->data struct on a table to increase lookup speed  
fk->table column whose values reference rows in another table   
schema->structural definition of a database  

####2 Create a database
some commands
```
grant all privileges on *.* to ''@'' identified by '';
show grants for 'user'@'%'
```

####4 Generate migrations
```
gails generate migration DoNothing
```
in db/migrate/1016...rb,default is
```
class DoNothing < ActiveRecord::Migration[5.0]
  def change
  end
end
```
change to
```
class DoNothing < ActiveRecord::Migration[5.0]
  def up
  end
  def down
  end
end
```

####5 Generate models
```
rails g model User
```
we can see
```
 invoke  active_record
 create    db/migrate/20160930030823_create_users.rb
 create    app/models/user.rb
 invoke    test_unit
 create      test/models/user_test.rb
 create      test/fixtures/users.yml
```
03:10
2016_create_users.rb
```
def up
    create_table :users do |t|
      t.column "first_name", :string
      t.column "last_name", :string    //same as   t.string "last_name"
      t.timestamps
    end
end
```
//binary boolean data datetime decimal float integer string text time

table column options
```
:limit=>size
:default=>value
:null=>true/false

:precision=>number
:scale=>number

####6 Run migrations
some query
````
show fields from users;
select * from schema_migrations;
```
05:20 undo migrations
```
rails db:migrate VERSION=0
```
get status
```
rails db:migrate:status
```
go to specific version
```
rails db:mirgate VERSION=20160930..
```
other method, up=one version up down=one previous version redo=redo previous activity
```
rails db:mirgate:up VERSION=20160930..
rails db:mirgate:down VERSION=20160930..
rails db:mirgate:redo VERSION=20160930..
```
####8 Solve migration problems
If fails a migrate, comment out a table that success until the failing line

###5. Models and ActiveRecord
####2 Model naming
```
rails g model SingularName
```
If you did not following naming convension when creating a model, in models/user.rb,
```
class User < ApplicationRecord
	self.table_name="admin_users"  //class is User, default name should be "users"
end
```

####6 Update records
```
ralis c
```
two step
```
user = AdminUser.new
user.new_record?
user.save
```
one step
```
AdminUser.create(:last_name=>"name")
```
AdminUser.find(1) //return error if not exists
AdminUser.find_by_id(1) //not return error if not exist, return null
user.created_at
user.updated_at
user.update_attribute(:name=>'other')
```


####7 Delete records
use destroy.
####9 Query methods: Conditions

```
Subject.where(:visible =>true)
```
chained
```
User.where().where()
```
get sql
```
irb(main):001:0> subjects = Subject.where(:visible=>true)
irb(main):001:0> subjects = Subject.where("visible=true")
irb(main):001:0> subjects = Subject.where(["visible=?",true])
irb(main):003:0> subjects.to_sql
```
####10 Query methods: Order, limit, and offset
no skip,sort (memorize api)  
syntax
```
order(:position)
order(:position => :asc)
order("position asc")

####11 Named scopes
exp:
```
scope :with_content_type, lambda {where{:active=>true}}
scope :active, -> {where{:active=>true}}
```
#evaluated when called, not defined.  
#chining scope
```
Article.active.recent
```

###6. Associations
####2 One-to-one
####3 One-to-many
we define ```has_many :pages``` in models/subject.rb, ```belongs_to :subject``` in models/page.rb  
```
subjects.pages.size
subjects.pages.count #same as above, but execute query
subjects.pages.empty?
```
####4 belongs_to presence validation
test validation.
```
page = Page.new(:name=>'ke')
page.save  #rollback error
page.errors.full_messages
```
by default this optional is false, like this
```
belongs_to :subject, {:optional=>true}
```
we can change to false.
###5 Many-to-many associations: Simple
join table naming, using _ to connect, and sort by alpha order
```
Project-Collaborator: collaborators_projects
```

###6 Many-to-many associations: Rich
we have two tables: courses, students. simple join: create table courses_students
complex join, we rename table to course_enrollments: so, courses:
```
has_many :course_enrollments
```
course_enrollments:
```
belongs_to :course
belongs_to :student
```
students:
```
has_many :course_enrollments
```

compare to many-to-many simple asso:
- still uses a join table with two indexed fk
- requires a primary key column(:id)
- join table has its own model  


Remember that belongs_to is no longer optional whether or not you have a parent relate to that. It's especially a problem when you're working with these join tables because there's more than one parent. 

####7 Traverse a rich association
```
has_many :through
```