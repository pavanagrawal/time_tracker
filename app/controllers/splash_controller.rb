class SplashController < ApplicationController
  skip_before_action :authenticate
  before_filter :authenticate_user!

  skip_before_action :verify_authenticity_token

  def get_timesheet_atom
    @category = Category.find params[:modal_category_id]
    @task = Task.find params[:modal_task_id]
    render partial: 'splash/timesheet_atom', locals: {category: @category, task: @task}
  end

  def post_timesheet
    params[:mins].each {|key, value|
      begin
        task_id, category_id, timesheet_date = key.split('$')
        puts "timesheet_date #{timesheet_date}"
        timesheet_date = Date.parse(timesheet_date)
        mins = value
        time_track = current_user.time_trackers.find_or_create_by(task_id: task_id, category_id: category_id, billable_date: timesheet_date)
        time_track.update(time_consumed: mins.to_i)
      rescue => e
        next
      end
    }

    render :text => 'Timesheet submitted successfully!'
  end

  def index
    @current_week_projects = current_user.current_week_projects
  end

  def new

  end

  def signup
    if ENV['MAILCHIMP_SPLASH_SIGNUP_LIST_ID'].blank? or ENV['MAILCHIMP_API_KEY'].blank?

      @message = "The MAILCHIMP_API_KEY and MAILCHIMP_SPLASH_SIGNUP_LIST_ID environment variables need to be set for mailing list signup to work! If you don't want this feature, you can just remove the mailing list signup feature from app/views/splash/index.html.haml"

    else
      begin

        gb = Gibbon::Request.new(api_key: ENV['MAILCHIMP_API_KEY'])

        gb.lists(ENV['MAILCHIMP_SPLASH_SIGNUP_LIST_ID']).members.create(
            body: {
                email_address: params[:signup_email],
                status: "pending"
            }
        )

        @message = 'Thanks for signing up!'

      rescue StandardError => e
        @error = true

        if e.message =~ /is already subscribed to the list/
          @message = "You're already signed up to receive updates. Thanks for your enthusiasm!"
        else
          @message = "Oops! Looks like we ran into an error. How embarrassing. Please try again later!"
        end

      end
    end
  end


  private

  def gem_available?(name)
    Gem::Specification.find_by_name(name)
  rescue Gem::LoadError
    false
  rescue
    Gem.available?(name)
  end

end
