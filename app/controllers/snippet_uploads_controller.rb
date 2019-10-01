class SnippetUploadsController < ApplicationController

  before_action :authenticate_user!

  before_action :set_snippet_upload, only: [:show, :edit, :update, :destroy]

  # GET /snippet_uploads
  # GET /snippet_uploads.json
  def index
    @snippet_uploads = SnippetUpload.all
  end

  # GET /snippet_uploads/1
  # GET /snippet_uploads/1.json
  def show
  end

  # GET /snippet_uploads/new
  def new
    @snippet_upload = SnippetUpload.new
  end

  # GET /snippet_uploads/1/edit
  def edit
  end

  # POST /snippet_uploads
  # POST /snippet_uploads.json
  def create
    @snippet_upload = SnippetUpload.new(snippet_upload_params)

    respond_to do |format|
      if @snippet_upload.save
        format.html { redirect_to @snippet_upload, notice: 'Snippet upload was successfully created.' }
        format.json { render :show, status: :created, location: @snippet_upload }
      else
        format.html { render :new }
        format.json { render json: @snippet_upload.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /snippet_uploads/1
  # PATCH/PUT /snippet_uploads/1.json
  def update
    respond_to do |format|
      if @snippet_upload.update(snippet_upload_params)
        format.html { redirect_to @snippet_upload, notice: 'Snippet upload was successfully updated.' }
        format.json { render :show, status: :ok, location: @snippet_upload }
      else
        format.html { render :edit }
        format.json { render json: @snippet_upload.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /snippet_uploads/1
  # DELETE /snippet_uploads/1.json
  def destroy

    @snippet_upload.destroy
    respond_to do |format|
      format.html { redirect_to snippet_uploads_url, notice: 'Snippet upload was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_snippet_upload
      @snippet_upload = SnippetUpload.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def snippet_upload_params
      params.require(:snippet_upload).permit(:title, files:[])
    end
end
