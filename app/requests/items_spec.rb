require 'rails_helper'

RSpec.describe 'Items API' do
  # Initialize the test data
  let!(:student) { create(:student) }
  let!(:items) { create_list(:item, 20, student_id: student.id) }
  let(:student_id) { student.id }
  let(:id) { items.first.id }

  # Test suite for GET /todos/:todo_id/items
  describe 'GET /students/:student_id/items' do
    before { get "/students/#{student_id}/items" }

    context 'when student exists' do
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns all student items' do
        expect(json.size).to eq(20)
      end
    end

    context 'when student does not exist' do
      let(:student_id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Student/)
      end
    end
  end

  # Test suite for GET /todos/:todo_id/items/:id
  describe 'GET /students/:student_id/items/:id' do
    before { get "/students/#{student_id}/items/#{id}" }

    context 'when student item exists' do
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns the item' do
        expect(json['id']).to eq(id)
      end
    end

    context 'when student item does not exist' do
      let(:id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Item/)
      end
    end
  end

  # Test suite for PUT /todos/:todo_id/items
  describe 'POST /students/:student_id/items' do
    let(:valid_attributes) { { name: 'Visit Narnia', done: false } }

    context 'when request attributes are valid' do
      before { post "/students/#{student_id}/items", params: valid_attributes }

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when an invalid request' do
      before { post "/students/#{student_id}/items", params: {} }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a failure message' do
        expect(response.body).to match(/Validation failed: Name can't be blank/)
      end
    end
  end

  # Test suite for PUT /todos/:todo_id/items/:id
  describe 'PUT /students/:student_id/items/:id' do
    let(:valid_attributes) { { name: 'Mozart' } }

    before { put "/students/#{student_id}/items/#{id}", params: valid_attributes }

    context 'when item exists' do
      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end

      it 'updates the item' do
        updated_item = Item.find(id)
        expect(updated_item.name).to match(/Mozart/)
      end
    end

    context 'when the item does not exist' do
      let(:id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Item/)
      end
    end
  end

  # Test suite for DELETE /todos/:id
  describe 'DELETE /students/:id' do
    before { delete "/students/#{student_id}/items/#{id}" }

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end
end