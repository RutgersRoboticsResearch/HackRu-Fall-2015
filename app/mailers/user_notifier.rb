class UserNotifier < ActionMailer::Base
  default from: "from@hackRU.com"

  def friend_requested(user_friendship_id)
  	user_friendship = UserFriendship.find(user_friendship_id)

  	@user = user_friendship.user
  	@friend = user_friendship.friend

  mail to: @friend.email,
  subject: "#{@user.first_name} wants to be your friend at HackRU"
  end

  def friend_request_accepted(user_friendship_id)
  	user_friendship = UserFriendship.find(user_friendship_id)

  	@user = user_friendship.user
  	@friend = user_friendship.friend

  mail to: @user.email,
  subject: "#{@friend.first_name} is accepted your friendship."
  end
end
