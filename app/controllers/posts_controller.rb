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
  
  def hashtags
    tag = Tag.find_by(name: params[:name])
    @posts = tag.posts
   #?s안붙나? 
  end
  
  #댓글 달기 
    def reply_create
      reply = Reply.new
      reply.content=params[:reply_content]
      reply.post_id=params[:post_id]
      reply.save
      redirect_to:back
    end
    
    def reply_update_view
      @post = Post.find(params[:post_id])
      @reply = Reply.find(params[:reply_id])
    end
  
  def reply_update
    @reply = Reply.find(params[:reply_id])
    @reply.content = params[:update_reply_content]
    @reply.save
    redirect_to posts_path(@post)
     
  end
    
   

  
  def reply_destroy
    @reply = Reply.find(params[:reply_id])
    @reply.destroy
    redirect_to:back
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
        format.html { redirect_to '/board', 
                      notice: 'Post was successfully created.'
        }
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

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def post_params
      params.require(:post).permit(:title, :content, :image)
    end

end
