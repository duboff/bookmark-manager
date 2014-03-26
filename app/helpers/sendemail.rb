helpers do

  def send_email(email, password_token)
    m = Mandrill::API.new 'lJl07Mtc5J5q3HoCQPs4VQ'
    message = {
      :subject=> "Password reset email",
      :from_name=> "Duboff's Bookmark Manager",
      :text=>"Hi, your password reset token is: ",
      :to=>[
        {
          :email=> email,
          :name=> "Friend"
        }
      ],
      :html=>"<html>Hi, your password reset token is: <a href='https://bookmark-manager-duboff.herokuapp.com/users/passwordreset/#{password_token}'>#{password_token}</a></html>",
      :from_email=>"admin@bookmark-manager-duboff.herokuapp.com"
    }
    sending = m.messages.send message
    puts sending

  end
end
