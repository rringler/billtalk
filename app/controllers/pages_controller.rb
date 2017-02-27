class PagesController < ApplicationController
  def root
    render react_component: 'Client', props: {}
  end
end
