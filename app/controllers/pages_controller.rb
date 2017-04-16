class PagesController < AdminAreaController

  layout 'admin'

  before_action :find_subjects, :only => [:new, :create, :edit, :update]
  before_action :set_page_count, :only => [:new, :create, :edit, :update]

  def index
    @pages = Page.all
  end

  def show
    @page = Page.find(params[:id])
  end

  def new
    @page = Page.new
  end

  def create
    # Instantiate the new object using form params
    @page = Page.new(page_params)
    # save object
    if @page.save
      # if save succeeds rediriect to the index action
      flash[:notice] = "Page created successfully."
      redirect_to(pages_path)
    else
      # if save fails display again using render so form data remains
      render('new')
    end
  end

  def edit
    @page = Page.find(params[:id])
    @page_count = Page.count
  end

  def update
    # Find a new object using the form parameters
    @page = Page.find(params[:id])
    # Update the object
    if @page.update(page_params)
      # If save succeeds, redirect to the show action
      flash[:notice] = "Page updated successfully."
      redirect_to(page_path)
    else
      # if save fails display again using render so form data remains
      render('edit')
    end
  end

  def delete
    @page = Page.find(params[:id])
  end

  def destroy
    # Find a new object using the form parameters
    @page = Page.find(params[:id])
    # Attempt to destroy
    if @page.destroy
      # If delete succeeds, redirect to the index action
      flash[:notice] = "Page deleted successfully."
      redirect_to(pages_path)
    else
      # if delete fails display again.
      render('delete')
    end
  end

  private

def page_params
  params.require(:page).permit(:name, :subject_id, :position, :is_visible, :permalink)
end

def find_subjects
  @subjects = Subject.sorted
end

def set_page_count
  @page_count = Page.count
  if params[:action] == 'new' || params[:action] == 'create'
    @page_count += 1
  end
end

end
