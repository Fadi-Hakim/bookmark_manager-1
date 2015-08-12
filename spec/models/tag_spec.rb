describe Tag do
  it "cannot be saved with an empty 'name' property" do
    tag = Tag.new(name: "")
    expect(tag.save).to be false
  end
end