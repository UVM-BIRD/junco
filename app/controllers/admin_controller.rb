class AdminController < ApplicationController
  def refresh
    if params['password'] == 'pass123'
      if params['file'] && params['file'] != ''
        DataLoader.new.load params['file'].path

      else
        flash.now[:alert] = 'Please specify a data file.'
      end

    elsif params['password'] && params['password'] != ''
      flash.now[:alert] = 'Invalid password.'
    end

    respond_to do |format|
      format.html
    end
  end
end
