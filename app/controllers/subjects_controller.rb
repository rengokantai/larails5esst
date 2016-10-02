class SubjectsController < ApplicationController
  def index
  	@subjects = Subject.sorted
  	render('index')
  end

  def show
  end

  def edit
  end
  def create
  end

  def update
  end

  def delete
  end

  def new
  end

  def destroy
  end
end
