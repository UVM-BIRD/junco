class AdminController < ApplicationController
  PASSWORD = '0rang3_w4lrUS'

  def refresh
    data_loader = DataLoader.instance

    if params['password'] == PASSWORD
      if params['file'] && params['file'] != ''
        begin
          data_loader.load params['file']
          flash.now[:notice] = 'Refresh started.'

        rescue Exception => e
          flash.now[:alert] = e.message
        end

      else
        flash.now[:alert] = 'Please specify a data file.'
      end

    elsif params['password'] && params['password'] != ''
      flash.now[:alert] = 'Invalid password.'

    elsif data_loader.is_running?
      flash.now[:notice] = 'Refresh in progress.'
    end

    flash.now[:error] = data_loader.error if data_loader.error != nil

    respond_to do |format|
      format.html
    end
  end
end
