class Users::RegistrationsController < Devise::RegistrationsController
  protected
      def after_inactive_sign_up_path_for(resource)
        "/thank_you"
      end
end
