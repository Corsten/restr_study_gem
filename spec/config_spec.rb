

RSpec.describe Config do
  it "has a version number" do
    expect(Config::VERSION).not_to be nil
  end

  # it "does something useful" do
  #   expect(false).to eq(true)
  # end

  it 'can store one int' do
    config = Config::Config.build do
      one 1
    end
    expect(config.one).to eq(1)
  end

  it 'can store string value' do
    config = Config::Config.build do
      two '2'
    end
    expect(config.two).to eq('2')
  end

  it 'can store node' do
    config = Config::Config.build do
      tree do
        node do
          surprise 'marat'
        end
        third 33
      end
    end
    expect(config.tree.node.surprise).to eq('marat')
    expect(config.tree.third).to eq(33)
  end

  it 'Have not this key' do
    config = Config::Config.build do
      ebal do
        ya do
          vrot do
            eti do
              testi true
            end
          end
        end
      end
    end
    expect(config.respond_to?(love)).to eq(false)
  end

  it 'Run without any params' do
    expect(Config::Config.build).to raise_error(NameError)
  end

  it "it return true always" do
    expect(true).to eq(true)
  end
end
