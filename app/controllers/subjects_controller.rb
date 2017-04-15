class SubjectsController < ApplicationController

  layout 'admin'

  before_action :set_subject_count, :only => [:new, :create, :edit, :update]

  def index
    @subjects = Subject.sorted
  end

  def show
    @subject = Subject.find(params[:id])
  end

  def new
    @subject = Subject.new({:name => "Default"})
  end

  def create
    # Instantiate the new object using form params
    @subject = Subject.new(subject_params)
    # save object
    if @subject.save
      # if save succeeds rediriect to the index action
      flash[:notice] = "Subject created successfully."
      redirect_to(subjects_path)
    else
      # if save fails display again using render so form data remains
      render('new')
    end
  end

  def edit
    @subject = Subject.find(params[:id])
  end

  def update
    # Find a new object using the form parameters
    @subject = Subject.find(params[:id])
    # Attempt to destroy
    if @subject.update_attributes(subject_params)
      # If delete succeeds, redirect to the index action
      flash[:notice] = "Subject updated successfully."
      redirect_to(subject_path(@subject))
    else
      # if delete fails display again.
      render('edit')
    end
  end


  def delete
    @subject = Subject.find(params[:id])
  end

  def destroy
    # Find a new object using the form parameters
    @subject = Subject.find(params[:id])
    # Attempt to destroy
    if @subject.destroy
      # If delete succeeds, redirect to the index action
      flash[:notice] = "Subject '#{@subject.name}' successfully."
      redirect_to(subjects_path)
    else
      # if delete fails display again.
      render('delete')
    end
  end

  private

  def subject_params
    params.require(:subject).permit(:name, :position, :is_visible, :created_at)
  end

  def set_subject_count
    @subject_count = Subject.count
    if params[:action] == 'new' || params[:action] == 'create'
      @subject_count += 1
    end
  end

end
