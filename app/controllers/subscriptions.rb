post '/subscriptions' do
  @subscription = Subscription.new(params[:subscription])
  if @subscription.save
    redirect "/users/#{current_user.id}"
  else
    @errors = @subscription.errors.full_messages
    erb :"/users/show"
  end
end

delete '/subscriptions' do
  @subscription = Subscription.find_by(params[:subscription])
  if logged_in?
    if current_user.id == @subscription.user.id
      @subscription.destroy
      redirect "/users/#{current_user.id}"
    else
      erb :'not_authorized'
    end
  else
    erb :'not_authorized'
  end
end