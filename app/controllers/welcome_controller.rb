class WelcomeController < ApplicationController

  def result
    RakutenWebService.configuration do |c|
      c.application_id = ENV["APPID"]
      c.affiliate_id = ENV["AFID"]
  end

      @books = RakutenWebService::Books::Book.search(:author => "夏目漱石",)
      erb :books_result
  end
end
