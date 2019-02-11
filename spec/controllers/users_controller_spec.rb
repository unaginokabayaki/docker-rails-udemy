require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  describe 'GET #new' do
    before { get :new }
    
    it 'レスポンスコードが200であること' do
      expect(response).to have_http_status(:ok)
    end

    it 'newテンプレートをレンダリングすること' do
      expect(response).to render_template :new
    end

    it '新しいuserオブジェクトがビューに渡されること' do
      expect(assigns(:user)).to be_a_new User
    end
  end

  describe 'POST #create' do
    before do
      @referer = 'http://192.168.100.99'
      @request.env['HTTP_REFERER'] = @referer
    end

    context '正しいユーザ情報が渡ってきた場合' do
      let(:params) do
        { user: {
            name: 'user',
            password: 'password',
            password_confirmation: 'password'
          }
        }
      end

      it 'ユーザが一人増えていること' do
        expect { post :create, params: params }.to change(User, :count).by(1)
      end

      it 'マイページにリダイレクトされること' do
        expect(post :create, params: params).to redirect_to(mypage_path)
      end
    end

    context 'パラメータが間違っている場合' do
      before do
        post(:create, params: {
          user: {
            name: 'ゆーざ',
            password: 'password',
            password_confirmation: 'invalid'
          }
        })
      end

      it 'リファラーにリダイレクトされること' do
        expect(response).to redirect_to(@referer)
      end

      it 'ユーザ名のエラーメッセージが含まれていること' do
        expect(flash[:error_messages]).to include 'ユーザー名は小文字英数字で入力してください'
      end

      it 'パスワード確認のエラーメッセージが含まれていること' do
        expect(flash[:error_messages]).to include 'パスワード（確認）とパスワードの入力が一致しません'
      end
     end
  end
end
