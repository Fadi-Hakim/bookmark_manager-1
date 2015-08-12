describe Link do
  it 'cannot be saved with an empty url' do
    link = Link.new(title: "something", url: "")
    expect(link.save).to be false
  end
end