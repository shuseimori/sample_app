require 'test_helper'

class UsersLoginTest < ActionDispatch::IntegrationTest
 
 def setup
  @user = users(:Shusei)
 end
 
 test "login with valid information followed by logout" do
 get login_path
 post login_path, params: { session: {email:@user.email,
                                      password:"moripon9"}}
 assert_redirected_to @user
 follow_redirect!
 assert_template "users/show"
 
 delete logout_path
 assert_not is_logged_in?
 assert_redirected_to root_url
 
  # 2番目のウィンドウでログアウトをクリックするユーザーをシミュレートする
    delete logout_path
 follow_redirect!
 
 end
 
 test "flash should disappear soon" do
   get login_path
   assert_template "sessions/new"
   post login_path, params:{session:{email:"", password:""}}
   assert_template "sessions/new"
   assert_not flash.empty?
   get root_path
   assert flash.empty?
 end
end
