require 'rails_helper'

# Test suite for the Comment model
RSpec.describe Comment, type: :model do
  # Association test
  it { should belong_to(:blog) }
  it { should belong_to(:user) }
  # Validation tests
  # ensure columns title and created_by are present before saving
  it { should validate_presence_of(:content) }
end
