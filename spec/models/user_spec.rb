# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  birthday        :date
#  name            :string(255)      not null
#  password_digest :string(255)      not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
# Indexes
#
#  index_users_on_name  (name) UNIQUE
#

require 'rails_helper'

RSpec.describe User, type: :model do
  # pending "add some examples to (or delete) #{__FILE__}"
  describe '#age' do
    before do
      allow(Time.zone).to receive(:now).and_return(Time.zone.parse('2018/04/01'))
    end

    context '20年前の生年月日の場合' do
      let(:user) { User.new(birthday: Time.zone.now - 20.years) }

      it '年齢が20であること' do
        expect(user.age).to eq 20
      end
    end

    context '10年前に生まれた' do
      let(:user) { User.new(birthday: Time.zone.parse('2008/04/01')) }

      it '年齢が10であること' do
        expect(user.age).to eq 10
      end
    end

    context '10年-1日前に生まれた' do
      let(:user) { User.new(birthday: Time.zone.parse('2008/04/02')) }

      it '年齢が10未満であること' do
        expect(user.age).to eq 9
      end
    end
  end
end
