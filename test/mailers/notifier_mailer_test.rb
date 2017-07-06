require 'test_helper'

class NotifierMailerTest < ActionMailer::TestCase
  
  e = new Exception
  
  test "error_occured" do
    mail = NotifierMailer.error_occured(e)
    assert_equal "Depot Exception Warning", mail.subject
    assert_equal ["846190988@qq.com"], mail.to
    assert_equal ["depot@example.com"], mail.from
    assert_match /This is just to inform you that an exception was raised and rescued in the Depot app./, mail.body.encoded
  end

end
