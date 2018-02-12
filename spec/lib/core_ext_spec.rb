RSpec.describe Hash do
  context 'trie' do
    let(:trie) do
      YAML.load <<~YML
      a:
        name: a
        b:
          name: b
          c:
            name: c
            d:
              name: d
              e:
                name: e
      YML
    end

    it 'can clone values from one branch to other appending suffixes' do
      trie.clone_values from_keys: ['a', 'b'],
                        to_keys: ['a', 'test'],
                        suffix: '-test'

      expect(trie['a']['test']['c']['name']).to eq('c-test')
      expect(trie['a']['test']['c']['d']['name']).to eq('d-test')
      expect(trie['a']['test']['c']['d']['e']['name']).to eq('e-test')
    end

    it 'can deep dup' do
      trie.deep_dup['a']['b'][:ddup] = 'lol'
      expect(trie['a']['b'][:ddup]).to be_nil
    end

  end
end