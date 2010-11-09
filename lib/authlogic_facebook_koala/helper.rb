module AuthlogicFacebookKoala
  module Helper
      def fb_login_button(*args)

        callback = args.first
        options = args[1] || {}
        options.merge!(:onlogin=>callback) if callback
        options.merge!(:perms=>"email,user_birthday,user_location", "show-faces" => "false", "width" => "500")
        text = options[:text] || "Login"

        content_tag("fb:login-button",text, options)
      end

      def authlogic_facebook_login_button(options = {})
        # TODO: Make this with correct helpers istead of this uggly hack.

        options[:controller] ||= "session"
        options[:js] ||= :jquery
        options[:id] = 'fb_login'

        case options[:js]
        when :prototype
          js_selector = "$('connect_to_facebook_form')"
        when :jquery
          js_selector = "jQuery('#connect_to_facebook_form')"
        end

        # output = "<form id='connect_to_facebook_form' method='post' action='/#{options[:controller]}'>\n"
        # output << "<input type='hidden' name='authenticity_token' value='#{form_authenticity_token}'/>\n"
        # output << "</form>\n"
        output = "<script type='text/javascript' charset='utf-8'>\n"
        output << " function connect_to_facebook() {\n"
        output << "   #{js_selector}.submit();\n"
        output << " }\n"
        output << "</script>\n"
        options.delete(:controller)
        output << fb_login_button("connect_to_facebook()", options)
        output
      end
      
      def authlogic_facebook_logout_button
        output = "<div><a id='facebook_logout_button'>Logout</a></div>\n"
        output << "<script type='text/javascript' charset='utf-8'>\n"
        output << "   jQuery('#facebook_logout_button').click(function() {\n"
        output <<       "FB.logout(function(response) { window.location.href='"+logout_path+"'; });\n";
        output << "   });\n"
        output << "</script>\n"
        output
      end
      
  end
end
