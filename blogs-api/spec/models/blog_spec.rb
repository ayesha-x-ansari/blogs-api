require 'rails_helper'

# Test suite for the Blog model
RSpec.describe Blog, type: :model do
  # Association test
  it { should belong_to(:user) } 
  it { should have_many(:comments) }
  it { should have_many(:users).through(:comments) }
  # Validation tests
  # ensure columns title and created_by are present before saving
  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:content) }
end
