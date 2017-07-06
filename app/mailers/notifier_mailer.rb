class NotifierMailer < ApplicationMailer

  default from: 'Depot Monitor <depot@example.com>'

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.notifier_mailer.error_occured.subject
  #
  def error_occured(error)
    @error = error
    mail :to => '846190988@qq.com', subject: 'Depot Exception Warning'
  end
  
end
