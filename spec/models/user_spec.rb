require 'rails_helper'

RSpec.describe User, type: :model do
  context 'has valid attributes' do
    before(:each) do
      @user = build(:user)
    end

    it 'should save' do
      expect(@user).to be_valid
    end
    
    it 'encrypts the password' do
      expect(@user.password_digest.present?).to eq(true)
    end

    it 'email as lowercase' do
      expect(create(:user).email).to eq ('donuts@mmm.com')
    end

  end

  context "with invalid attributes should not save if" do 
    
    it 'name is blank' do
      expect(build(:user, name: '')).to be_invalid
    end

    it 'email is blank' do
      expect(build(:user, email: '')).to be_invalid
    end

    it 'email format is wrong' do
      emails = %w[@ user@ @example.com]
      emails.each do |email|
        expect(build(:user, email: email)).to be_invalid
      end
    end

    it 'email is not unique' do
      create(:user)
      expect(create(:user)).to be_invalid
    end

    it 'password is blank' do
      expect(build(:user, password: '')).to be_invalid
    end
    it "password doesn't match password_confirmation" do
      expect(build(:user, password_confirmation: 'notpassword')).to be_invalid
    end
  end
end
