require 'spec_helper'

describe KaraagePosting do
  describe 'version specs' do
    it 'has a version number' do
      expect(KaraagePosting::VERSION).not_to be nil
    end
    
    it 'equals the version number' do
      expect(KaraagePosting::VERSION).to eq "0.0.1"
    end
  end
end
