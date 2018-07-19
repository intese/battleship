require 'rails_helper'

describe ShipItem do
  let(:ship) { nil }
  subject { ShipItem.new(x: 1, y: 2, ship: ship) }
  it { expect(subject.dead_status).to eq 'X' }

  context 'show_state' do
    context 'ship is dead' do
      before(:each) { subject.shoot }
      let(:ship) {double(:ship, dead?: true)}
      it { expect(subject.show_state).to eq '$' }
    end
  end
end
