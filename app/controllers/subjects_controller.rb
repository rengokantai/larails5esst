class SubjectsController < ApplicationController
  def index
  	@subjects = Subject.sorted
  	render('index')
  end

  def show
    @subject = Subject.find(params[:id])
  end

  def edit
  end
  def create
    @subject = Subject.new(subject_params)
    if @subject.save
      redirect_to(subjects_path)
    else
      render('new')
    end
  end

  def update
  end

  def delete
  end

  def new
    @subject = Subject.new
  end

  def destroy
  end

  private
  def subject_params
    params.require(:subject).permit(:name,:position,:visible)
  end
end
