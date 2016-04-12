module Spree
  module Admin
    class TimeFramesController < ResourceController
      before_action :load_data, except: :index

      def model_class
        Dish::TimeFrame
      end

      def show
        redirect_to action: :edit
      end

      def load_data
      end

      def location_after_save
        admin_time_frames_url
      end
    end
  end
end