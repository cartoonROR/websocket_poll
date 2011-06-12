class SubPollsController < ApplicationController
  before_filter :require_user
  def index
    @poll = Poll.includes(:sub_polls).where(:polls => {:id => params[:id],:user_id => current_user.id}).first()
  end

  def save_item
    if params[:item_id].to_s == ""
      @sub_poll = SubPoll.create(:poll_id => params[:id],:name => params[:name],:point => 0)
    else
      @sub_poll = SubPoll.find params[:item_id]
      @sub_poll.name = params[:name]
      @sub_poll.save
    end
    
    render :json => @sub_poll
  end

  def delete_item
    @sub_poll = SubPoll.find(params[:id])
    @sub_poll.destroy
    render :json => true
  end
end
