RSpec.describe Config do
  it "has a version number" do
    expect(Config::VERSION).not_to be nil
  end

  # it "does something useful" do
  #   expect(false).to eq(true)
  # end

  it 'can store one int' do
    c = Config::Config.build do

    end
  end

  it "it return true always" do
    expect(true).to eq(true)
  end
end
