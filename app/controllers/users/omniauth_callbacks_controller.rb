module Users
  class OmniauthCallbacksController < Devise::OmniauthCallbacksController
    # See https://github.com/omniauth/omniauth/wiki/FAQ#rails-session-is-clobbered-after-callback-on-developer-strategy
    # skip_before_action :verify_authenticity_token, only: :facebook

    def sign_in_with_slack
      # MEMO: omniauthでuser infoが取れないのでapiで取得する
      @user = OmniauthSupport::SignInWithSlack.from_omniauth(request.env["omniauth.auth"])

      sign_in_and_redirect @user, event: :authentication # this will throw if @user is not activated
      # set_flash_message(:notice, :success, kind: "") if is_navigational_format?
    end

    def failure
      redirect_to root_path
    end
  end
end