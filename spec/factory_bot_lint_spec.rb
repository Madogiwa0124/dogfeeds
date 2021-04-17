require 'rails_helper'

RSpec.describe FactoryBot, type: :model do
  describe '.lint' do
    it 'すべてのFactoryが正常に機能すること' do
      FactoryBot.lint traits: true
    end
  end
end
