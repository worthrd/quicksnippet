require "rexml/document"
include REXML 


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

    @snippet_upload.user = current_user

    respond_to do |format|
      if @snippet_upload.save
        @snippet_upload.files.each do |file|
          upload_to_snippet(file,current_user,@snippet_upload)
        end

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

  def upload_to_snippet(file,user,snippet_upload)
    content = file.download
    content_s =  content.bytes.pack("c*").force_encoding("UTF-8") 
    if file.filename.to_s.ends_with? ".sqlpromptsnippet"
       doc = Document.new content_s
       title = XPath.first(doc, "//CodeSnippets/CodeSnippet/Header/Title").text
       snippet_text = XPath.first(doc, "//CodeSnippets/CodeSnippet/Snippet/Code").text
       post = Post.new(title: title, content: snippet_text, user: user, snippet_upload: snippet_upload)
       post.save
    else
       post = Post.new(title: snippet_upload.title, content: content_s, user: user, snippet_upload: snippet_upload)
       post.save
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
