require "rexml/document"
include REXML 

class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy]

  # GET /posts
  # GET /posts.json
  def index
    @posts = Post.all
  end

  # GET /posts/1
  # GET /posts/1.json
  def show
  end

  # GET /posts/new
  def new
    @post = Post.new
  end

  # GET /posts/1/edit
  def edit
  end

  # POST /posts
  # POST /posts.json
  def create
    @post = Post.new(post_params)

    respond_to do |format|
      if @post.save
        format.html { redirect_to @post, notice: 'Post was successfully created.' }
        format.json { render :show, status: :created, location: @post }
      else
        format.html { render :new }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /posts/1
  # PATCH/PUT /posts/1.json
  def update
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to @post, notice: 'Post was successfully updated.' }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    @post.destroy
    respond_to do |format|
      format.html { redirect_to posts_url, notice: 'Post was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def search

    begin

      content = '<?xml version="1.0" encoding="utf-8"?>
        <CodeSnippets>
          <CodeSnippet Format="1.0.0">
            <Header>
              <Title>stepsByAutoId</Title>
              <Shortcut>stepsByAutoId</Shortcut>
              <Description />
              <Author />
              <SnippetTypes>
                <SnippetType>Expansion</SnippetType>
              </SnippetTypes>
            </Header>
            <Snippet>
              <Declarations />
              <Code Language="sql"><![CDATA[SELECT   fwfs.AutoId,''EXEC dbo.PS_Workflow_DWFSAutoId '' + CAST(fwfs.AutoId AS NVARCHAR(MAX)),tc.AutoId,fwi.AutoId,fwfd.Name,fwfsd.ControllerClass, fwfsd.Name,fwfsd.CaptionTr,fwfs.CreateUserTime FROM FWFStep fwfs 
        JOIN dbo.FWFStepDef fwfsd WITH (NOLOCK) ON fwfs.WFStepDefId = fwfsd.ID
        JOIN dbo.FWFInstance fwi WITH (NOLOCK) ON fwi.ID = fwfs.WFInstanceId
        JOIN dbo.FWFDefinition fwfd WITH (NOLOCK) ON fwfd.ID = fwfsd.WFDefinitionId
        JOIN dbo.TProductInstanceBase tpib WITH (NOLOCK) ON tpib.ID = fwi.RecID
        JOIN dbo.TContractDetail tcd WITH (NOLOCK) ON tcd.ID = tpib.ContractDetailId
        JOIN dbo.TCustomer tc WITH (NOLOCK) ON tc.ID = tcd.CustomerId
        WHERE 
        --fwfs.AutoId = 344624150
        fwi.AutoId = 40791481 
        AND fwfs.GcRecordId IS NULL ORDER BY fwfs.AutoId]]></Code>
            </Snippet>
          </CodeSnippet>
        </CodeSnippets>'
    
      doc = Document.new content

      title = XPath.first(doc, "//CodeSnippets/CodeSnippet/Header/Title").text

      s = XPath.first(doc, "//CodeSnippets/CodeSnippet/Snippet/Code").text

      respond_to do |format|
        format.html { redirect_to posts_url, notice: s.to_s }
        format.json { head :no_content }
      end
    

    rescue StandardError => msg
      format.html { render :show }
      format.json { render json: msg, status: :unprocessable_entity }
    end
                  
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def post_params
      params.require(:post).permit(:title, :content, :user_id, :snippet_upload_id)
    end
end
