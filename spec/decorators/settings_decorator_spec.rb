# coding: utf-8
require 'rails_helper'

describe SettingsDecorator do
  let(:settings) { Settings.new.extend SettingsDecorator }
  subject { settings }
  it { should be_a Settings }
end
