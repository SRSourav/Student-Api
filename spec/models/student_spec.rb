require 'rails_helper'

# Test suite for the Todo model
RSpec.describe Student, type: :model do
  # Association test
  # ensure Todo model has a 1:m relationship with the Item model
  it { should have_many(:items).dependent(:destroy) }
  # Validation tests
  # ensure columns title and created_by are present before saving
  it { should validate_presence_of(:full_name) }
  it { should validate_presence_of(:roll) }
end