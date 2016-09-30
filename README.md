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
