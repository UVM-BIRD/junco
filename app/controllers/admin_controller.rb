class AdminController < ApplicationController
  def refresh
    if params['password'] == 'pass123'
      if params['file'] && params['file'] != ''
        begin
          DataLoader.load params['file'].path
          flash.now[:notice] = 'Refresh started.'

        rescue Exception => e
            flash.now[:alert] = e.message
        end

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
