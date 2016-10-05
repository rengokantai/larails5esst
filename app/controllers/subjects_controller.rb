class SubjectsController < ApplicationController

  layout 'admin'
  before_action :confirm_logged_in
  before_action :set_subject_count, :only => [:new, :create, :edit, :update]

  def index
  	@subjects = Subject.sorted
  	#render('index')
  end

  def show
    @subject = Subject.find(params[:id])
  end

  def edit
    @subject = Subject.find(params[:id])
    #@subject_count = Subject.count
  end
  def create
    @subject = Subject.new(subject_params)
    if @subject.save
      flash[:notice]="subject created"
      redirect_to(subjects_path)
    else
      #@subject_count = Subject.count+1
      render('new')
    end
  end

  def update
    @subject = Subject.find(params[:id])
    #@subject = Subject.new(subject_params)
    if @subject.update_attributes(subject_params)
      flash[:notice]="subject updated"
      redirect_to(subjects_path(@subject))
    else
      #@subject_count = Subject.count
      render('edit')
    end
  end

  def delete
    @subject = Subject.find(params[:id])
  end

  def new
    @subject = Subject.new({:name => 'Default'})
  end

  def destroy
    @subject = Subject.find(params[:id])
    @subject.destroy
    flash[:notice]="subject '#{@subject.name}' deleted"
    redirect_to(subjects_path)
  end

  private
  def subject_params
    params.require(:subject).permit(:name,:position,:visible,:created_at)
  end
  def set_subject_count
    @subject_count = Subject.count
    if params[:action] == 'new' || params[:action] == 'create'
      @subject_count += 1
    end
  end
end
