class ShowPollsController < ApplicationController

  skip_before_filter :verify_authenticity_token

  def index
    @poll = Poll.find_by_key(params[:id])
    if cookies[:dev_appserver_login] == params[:id]
      @sub_polls = SubPoll.includes(:poll).where(:polls => {:key => params[:id]})
      @polls = Array.new
      number = 0
      @sub_polls.each do |sub_poll|
        @polls[number] = [sub_poll.name,sub_poll.point]
        number += 1
      end
    end
  end

  def save
    cookies[:dev_appserver_login] = {:value => params[:key]}
    @sub_poll = SubPoll.includes(:poll).where(:polls => {:key => params[:key]},:sub_polls => {:name => params[:data]}).first()
    @sub_poll.point += 1
    @sub_poll.save
    @sub_polls = SubPoll.includes(:poll).where(:polls => {:key => params[:key]})
if params[:vote].nil?
      send_to_clients [@sub_polls,params[:key],"vote"]
else
         send_to_clients [@sub_polls,params[:key],"socky"]
    end
    render :json => [@sub_polls,params[:key]]

  end

  private

  def send_to_clients(data)
    Socky.send(data.to_json)
  end

end
