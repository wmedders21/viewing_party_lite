

RSpec.describe User, type: :model do
  describe 'validations' do
    it { should validate_presence_of (:name) }
    it { should validate_presence_of (:email) }
    it { should validate_uniqueness_of (:email) }

    it { should have_secure_password }

    it 'should have a secure password' do
      user = User.create!(name: 'Will', email: 'abc@email.com', password: '123qwe!!!zxc')
      expect(user).to_not have_attribute(:password)
      expect(user.password_digest).to_not eq('123qwe!!!zxc')
    end
  end

  describe 'relationships' do
    it { should have_many(:party_users) }
    it { should have_many(:parties).through(:party_users) }
  end

  describe 'class methods' do
    User.destroy_all
    it '#email_list' do
      user_1 = User.create!(name: 'Will', email: 'abc@mail.com', password: 'ergege')
      user_2 = User.create!(name: 'Craig', email: 'zyx@mail.com', password: 'rtgh45g')
      user_3 = User.create!(name: 'Alicia', email: '321@mail.com', password: '34v435t3r')

      expect(User.email_list).to eq([user_1.email, user_2.email, user_3.email])
    end
  end
end
