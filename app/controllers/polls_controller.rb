class PollsController < ApplicationController
  before_filter :require_user
  def index
    @polls = Poll.find_all_by_user_id current_user.id
  end

  def new
    @poll = Poll.new
  end

  def create
    @poll = Poll.new(params[:poll])
    @poll.user_id = current_user.id
    @poll.key = ('A'..'z').to_a.shuffle[0..30].join
    if @poll.save
      redirect_to :action => "index"
    else
      format.html { render :action => "new" }
      format.xml  { render :xml => @poll.errors, :status => :unprocessable_entity }
    end
  end

  def edit
    @poll = Poll.find(params[:id])
  end

  def update
  @poll = Poll.find(params[:id])
  @poll.name = params[:poll][:name]
  @poll.detail = params[:poll][:detail]
  respond_to do |format|
    if @poll.save
      format.html { redirect_to(polls_url) }
      format.xml  { head :ok }
    else
      format.html { render :action => "edit" }
      format.xml  { render :xml => @poll.errors,:status => :unprocessable_entity }
    end
  end
end

  def destroy
    @poll = Poll.find(params[:id])
    @poll.destroy

    respond_to do |format|
      format.html { redirect_to(polls_url) }
      format.xml  { head :ok }
    end
  end

end
