require 'rails_helper'

describe "post a destination route", :type => :request do

  before do
    post '/destinations', params: {
      name: 'Qwerty',
      city: 'PDX',
      locale: 'Oregon',
      country: 'USA'
    }
  end


  it 'returns the destination name' do
    expect(JSON.parse(response.body)['name']).to eq('Qwerty')
  end

  it 'returns the destination city' do
    expect(JSON.parse(response.body)['city']).to eq('PDX')
  end

  it 'returns the destination locale' do
    expect(JSON.parse(response.body)['locale']).to eq('Oregon')
  end

  it 'returns the destination country' do
    expect(JSON.parse(response.body)['country']).to eq('USA')
  end

  it 'returns a created status' do
    expect(response).to have_http_status(:created)
  end

  it 'returns error for missing param in destination post' do
    post '/destinations', params: {
      name: '',
      city: 'PDX',
      locale: 'Oregon',
      country: 'USA'
    }
    expect(response).to have_http_status(422)
  end
end
