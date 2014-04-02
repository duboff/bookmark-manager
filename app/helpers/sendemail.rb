helpers do

  def send_recovery_email(email, password_token)
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

  def send_welcome_email(email)
    m = Mandrill::API.new 'lJl07Mtc5J5q3HoCQPs4VQ'
    message = {
      :subject=> "Welcome",
      :from_name=> "Duboff's Bookmark Manager",
      :text=>"Good job on signing up. It's the most amazing site in the world.",
      :to=>[
        {
          :email=> email,
          :name=> "Friend"
        }
      ],
      :html=>"<html>Good job on signing up. It's the most amazing site in the world.</html>",
      :from_email=>"admin@bookmark-manager-duboff.herokuapp.com"
    }
    sending = m.messages.send message
    puts sending

  end
end
