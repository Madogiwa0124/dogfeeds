# frozen_string_literal: true

require 'rails_helper'

describe Lograge::Formatters::MarkedKeyValue do
  let(:payload) do
    {
      custom: 'data',
      status: 200,
      method: 'GET',
      path: '/',
      controller: 'welcome',
      action: 'index'
    }
  end

  subject { described_class.new.call(payload) }

  it "includes the 'controller' key/value" do
    expect(subject).to include('controller=welcome')
  end

  it "includes the 'action' key/value" do
    expect(subject).to include('action=index')
  end

  it "includes the 'mark' by status" do
    expect(subject).to include('😃')
  end
end
