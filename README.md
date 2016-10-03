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
Rails gives us a tool for this using has many through. It allows reaching across a rich join and treating it like it's a has and belongs to many join.  

So. edit admin_user.rb
```
class AdminUser < ApplicationRecord
	attr_accessor :first_name
	def last_name
		@last_name
	end

	def last_name(v)
		@last_name=v
	end
	has_and_belongs_to_many :pages
	has_many :section_edits
	has_many :sections, :through => :section_edits
end
```
section.rb
```
class Section < ApplicationRecord
	belongs_to :page
	has_many :section_edits
	has_many :admin_users, :through => :section_edits
end
```
then in rails console,
```
me =
me
```

###7. CRUD
####1 CRUD
```
rails g controller Subjects index show new edit delete
```
other three,
```
create, update, destroy
```
do not need template,just action.

####3 Resourceful routes
ex,delete is not included in the default actions defined by resources, so you would need to add it in the way
```
resources :subjects do
	member do
		get :delete
	end

	collection do
		get :export
	end
end
```
You can use :except and :only in order to list the actions which should be given routes. And as we just saw with delete, it's also possible to add additional resources. There are two different types of routes that we can add. There's member and collection. Member routes operate on a member of the resource. In other words, they expect to receive a record ID in the URL. Edit and update are examples of built-in routes that are member routes. Collection routes operate on the resource as a whole. In other words, they do not expect to get a record ID in the URL. Index is an obvious example of a built-in member route, but new and create also operate on the collection as a whole, not on an existing member.  

check
```
rails routes
```
####4 Resourceful URL helpers
ex
```
<%= link_to('text',subjects_path) %>
<%= link_to('text',subjects_path(:page=>3)) %>
<%= link_to('text',subjects_path(@subject.id)) %>
```
###8. Controllers and CRUD

####2 Read action: Show
one way is
```
<%= link_to("show",'subjects/#{subject.id}')%>
```
or using hash
```
<%= link_to("show",{:controller=>'subjects',:action=>'show',:id=>subject.id})%>
```
or using convention
```
<%= link_to("show",subject_path(subject))%> #same as
<%= link_to("show",subject_path(subject.id))%>
```
####4 Create action: New
use form_for helper. actually
```
<%= form_for(@subject, :url => subjects_path, :method => 'post') do |f| %>
```
is same as
```
<%= form_for(@subject) do |f| %>
```

for controller.action.new, we can create default value
```
def new
    @subject = Subject.new
end
```
can be
```
def new
    @subject = Subject.new({:name=>'default'})
end
```

####5 Create action: Create

create action. render('new') can preserve previous submitted form.
```
  def create
    @subject = Subject.new(params[:subject])
    if @subject.save
      redirect_to(subjects_path)
    else
      render('new')
    end
  end
```
This may cause ActiveModel::ForbiddenAttributesError in SubjectsController#create

####6 Strong parameters
mass assignment. like
```
Subject.create(params[:subject])
Subject.new(params[:subject])
@subject.update_attributes(params[:subject])
```
All we have to do is tell the params hash what attributes to permit on each request. Permit is a method that marks the attributes as being available for mass assignment. By default, all values in the params hash are unavailable for mass assignment. We must whitelist the ones that we want to allow. There's another method called require and require ensures that a parameter is present. If our attributes hash is assigned to subject, then we need to make sure that subject is in the params.

####7 Update actions: Edit/update
for update,
```
<%= form_for(@subject) do |f| %>
```
is same as
```
<%= form_for(@subject, :url => subjects_path(@subject), :method => 'patch') do |f| %>
```


####8 Delete actions: Delete/destroy
```
<%= form_for(@subject,:url => subjects_path(@subject), :method => 'delete') do |f| %>
```
same as
```
<%= form_for(@subject), :method => 'delete') do |f| %>
```
####11: Solution
```
rails g controller Pages index show new edit delete
rails g controller Sections index show new edit delete
```


###9. Layouts, Partials, and
####1 Layouts
we can put
```
@page_title = "all sbj"
```
in pages_controller,or put in templates
```
<%@page_title = "all sbj"%>
```

####2 Partial templates
This is incorrect,
```
<%= render(:partial =>'form') %>
```
we must define a local variable, such as
```
<%= render(:partial =>'form',:locals=>{:f=>f}) %>
```
:f=>f, first f = f in partial file, second f=f in this file

####3 Text helpers
ex
```
<%= word_wrap(text,:line_width=>30) %>
```
simple_format, \n-><br/>
```
<%= simple_format(text) %>
```
truncte. omission string default = ..., included in total count
```
<%= truncate(text,:truncate=>30) %>
```
pluralize
```
<%[0,1,2].each do |n| %>
<%= pluralize(n,'product')%> found.
<%end%>
```
others: truncate_words, highlight,excerpt

####4 Number helpers
```
number_to_currency/number_to_percentage/
number_with_precision=number_to_rounded
number_with_delimiter=number_to_delimited
number_to_human/number_to_human_size/number_to_phone
```
options
```
:delimitor
:seperator
:precision
```
ex
```
number_to_currency(1.5,:precision=>0,:unit=>"ch",:format=>"%n %u")
number_to_percentage(1.5,:precision=>1,:seperator=>',') #1,5%
```

default precision=3
```
number_with_precision(12.121212) #12.121
number_with_precision(12.121212,:precision=>7) #12.1212120
```
to human

```
number_to_human(123456789) #123 million
number_to_human(123456789,:precision=>4) #123.4 million
```
```
number_to_human_size(123456789) #123 mb
number_to_human_size(123456789,:precision=>4) #123.4 mb
```

```
number_to_phone(1234567890) #123-456-7890
number_to_phone(1234567890,:area_code=>true,:delimiter=>' ',:country=>1,:extension=>'321') #+1(123) 456-7890 *321

####5 Date and time helpers
Time.now - 1 day = 30.days.ago   
Time.now + 1 day = 30.days.from_now 

datetime methods
```
Time.now.strftime("%B %d,%Y %H:%M")  #September 30, 2016 09:12
```
to_s
```
Time.now.to_s(:long)
```

####6 Custom helpers
code in app/helpers/application_helper.rb,set a status_tag to add a span tag used to present status of visible.

####7 Sanitization helpers
(In old version rails, we need to call html_escape()/h()  )


By default, rails escape strings(HTML tags), to restore, use raw
```
<%= raw string %>
```
remove links
```
strip_links(text)
```
sanitize output(allow these tags)
```
sanitize(@subject.content, :tags=>['p','br','strong','em'],:attributes=>['id','class','style'])
```

###10. Assets
####1 Asset pipeline
app/assets/*
precompilation:
```
export RAILS_ENV=production
bundle exec rails assets:precompile
```
####2 Stylesheets
The first is write the stylesheets. Then add the stylesheet to the manifest file, and add the manifest file to Rail's asset precompile list. That will ensure that Asset Pipeline is able to put together a stylesheet that's ready for serving to the browser.  

By default, we have a manifest file here called application.css.  

The lines that are down here that include an equal sign, those are the directives that tell the manifest file what it should load in. Notice that there are two directives already. The first is require_tree and then a period after it. That tells it to load in all of the files that are included in the stylesheets directory. The period is the current directory, and tree means require all the files that are there.  

And then the other one is require_self. This is a directive that says that it should load in any styles that we might happen to have in this file so that those get included as well.(not recommended)  


create admin.css
```
* require_tree .
*= require primary
*= require admin_additions
*= require_self
```
then we need to tell rails precompile info
in config/initializers/assets.rb,uncomment/add(for multiple files, do not need to add comma)
```
Rails.application.config.assets.precompile += %w( admin.css )
```
css helper tag, default: :media=>'screen'
```
<%= stylesheet_link_tag('application') %>
<%= stylesheet_link_tag('application', :media=>'all') %>
```
####3 Javascript
```
<%= javascript_include_tag('application') %>
```

####4 JavaScript tag and sanitizing
using j function.
```
<% text = "');alert('bad code!" %>
<%= javascript_include_tag('application#{j(text)}') %>
```
####5 Images
with asset pipeline: app/assets/images  
without: /public/images
```
<%= image_tag('src.png',:alt=>'',:width=>10,:height=>20)%>
<%= image_tag('src.png',:alt=>'',:size=>'10x20')%>
```

image helper tag in css instead use url(''), use image-url, like
```
background: $light_brown image-url('footer_gradient.png') repeat-y 0 0;
```

###11. Forms
####1 Form helpers
3 styles: tag style, object aware style, and form builder style
```
<%= text_field_tag('name',params[:name])%>
<%= text_field(:subject,:name)%>
<%= f.text_field(:name)%>
```
text_field password_field text_area hidden_field radio_button check_box file_field label  
ex:
```
form_for(@subject, :html=>{:multipart=>true})do |f|
```
radio button sample
```
<tr>
    <th>Content type</th>
    <td>
      <%= f.radio_button(:content_type, 'text') %> Text
      <%= f.radio_button(:content_type, 'HTML') %> HTML
    </td>
  </tr>
```

####2 Form options helpers
some exp
```
form_for(@section) do |f|
	f.select(:position 1..4)
	f.select(:content_type,['text','html'])
	f.select(:visible,['text'=>1,'html'=>2])
	f.select(:page_id,Page.all.map{|p| p.name,p.id})
end
```
####3 Date and time
```
date_select(object,attribute,options,html_options)
time_select(object,attribute,options,html_options) # :include_seconds=>false,:minute_step=>1,:include_blank=>false,:time_seperator=>":"
```
