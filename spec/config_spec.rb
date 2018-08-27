RSpec.describe Config do
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
      country do
        state do
          city do
            street do
              house 'home sweet home'
            end
          end
        end
      end
    end
    expect(config.respond_to?(house)).to eq('home sweet home')
  end

  it 'Run without any params' do
    expect(Config::Config.build).to raise_error(NameError)
  end

  it 'it return always true' do
    expect(true).to eq(true)
  end
end
