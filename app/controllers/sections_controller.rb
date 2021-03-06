class SectionsController < AdminAreaController

  layout 'admin'

  before_action :find_page
  before_action :find_pages, :only => [:new, :create, :edit, :update]
  before_action :set_section_count, :only => [:new, :create, :edit, :update]

  def index
    @sections = @page.sections.sorted
  end

  def show
    @section = Section.find(params[:id])
  end

  def new
    @section = Section.new(:page_id => @page.id)
  end

  def create
    # Instantiate the new object using form params
    @section = Section.new(section_params)
    # save object
    if @section.save
      # if save succeeds rediriect to the index action
      flash[:notice] = "Section created successfully."
      if @section.page_id != @page.id
        @page = Page.find(@section.page_id)
      end
      redirect_to(sections_path(:page_id => @page.id))
    else
      # if save fails display again using render so form data remains
      render('new')
    end
  end

  def edit
    @section = Section.find(params[:id])
  end

  def update
    # Find a new object using the form parameters
    @section = Section.find(params[:id])
    # Attempt to destroy
    if @section.update_attributes(section_params)
      # If delete succeeds, redirect to the index action
      flash[:notice] = "Section updated successfully."
      redirect_to(section_path(@section, :page_id => @page.id))
    else
      # if delete fails display again.
      render('edit')
    end
  end


  def delete
    @section = Section.find(params[:id])
  end

  def destroy
    # Find a new object using the form parameters
    @section = Section.find(params[:id])
    # Attempt to destroy
    if @section.destroy
      # If delete succeeds, redirect to the index action
      flash[:notice] = "Section '#{@section.name}' successfully."
      redirect_to(sections_path(:page_id => @page.id))
    else
      # if delete fails display again.
      render('delete')
    end
  end

  private

  def section_params
    params.require(:section).permit(:name, :page_id, :position, :is_visible, :content_type, :content)
  end

  def find_page
    @page = Page.find(params[:page_id])
  end

  def find_pages
    @pages = Page.sorted
  end

  def set_section_count
    @section_count = @page.sections.count
    if params[:action] == 'new' || params[:action] == 'create'
      @section_count += 1
    end
  end

end
