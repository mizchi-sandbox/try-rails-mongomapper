class WelcomeController < ApplicationController
  def index
    @foo = Foo.create
    Foo.count
  end
end
