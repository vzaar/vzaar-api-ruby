require_relative './../spec_helper'

module VzaarApi
  describe 'Category: Create / Update / Delete' do

    let(:described_class) { Category }

    context 'when user is authenticated' do
      before { setup_for :account_owner }

      let(:attrs) { { name: 'new SDK category' } }

      it 'creates, updates and deletes a resource' do
        # name is required
        expect{described_class.create}.to raise_error(
          Error, "Invalid parameters: name is missing"
        )

        # create new category tree
        category = described_class.create attrs
        expect(category.name).to eq 'new SDK category'
        expect(category.parent_id).to be_nil
        expect(category.depth).to eq 0

        subcategory = described_class.create attrs.merge(parent_id: category.id)
        expect(subcategory.name).to eq 'new SDK category'
        expect(subcategory.parent_id).to eq category.id
        expect(subcategory.depth).to eq 1

        subsubcategory = described_class.create attrs.merge(parent_id: subcategory.id)
        expect(subsubcategory.name).to eq 'new SDK category'
        expect(subsubcategory.parent_id).to eq subcategory.id
        expect(subsubcategory.depth).to eq 2

        expect(described_class.find(category.id).tree_children_count).to eq 2
        expect(described_class.find(category.id).node_children_count).to eq 1
        expect(described_class.find(subcategory.id).node_children_count).to eq 1

        # can't create subcategories deeper than account will allow
        expect{
          described_class.create(attrs.merge(parent_id: subsubcategory.id))
        }.to raise_error(
          Error, 'Invalid parameters: Validation failed: Category depth must not exceed 3'
        )

        # perform update
        name = "updated at: #{Time.now.utc}"
        category.name = name
        category.save
        expect(category.name).to eq name

        # move category and children to top level
        subcategory.move_to_root = true
        subcategory.save
        expect(subcategory.parent_id).to be_nil
        expect(subcategory.depth).to eq 0
        expect(described_class.find(subsubcategory.id).depth).to eq 1
        expect(described_class.find(category.id).node_children_count).to eq 0

        expect(described_class.find(category.id).tree_children_count).to eq 0
        expect(described_class.find(category.id).node_children_count).to eq 0
        expect(described_class.find(subcategory.id).node_children_count).to eq 1

        # move category and children to a new parent
        subcategory.parent_id = category.id
        subcategory.save
        expect(subcategory.parent_id).to eq category.id
        expect(subcategory.depth).to eq 1
        expect(subsubcategory.depth).to eq 2

        expect(described_class.find(category.id).tree_children_count).to eq 2
        expect(described_class.find(category.id).node_children_count).to eq 1
        expect(described_class.find(subcategory.id).node_children_count).to eq 1

        # can't move if it will exceed category depth limit
        new_cat = described_class.create(attrs)
        new_cat.parent_id = subsubcategory.id
        expect{new_cat.save}.to raise_error(
          Error, 'Invalid parameters: Category depth must not exceed 3'
        )

        # delete categories
        subsubcategory.delete
        expect{ described_class.find(subsubcategory.id) }.to raise_error(
            Error, 'Not found: Resource cannot be found')

        # deleting parent deletes children
        category.delete
        expect{ described_class.find(category.id) }.to raise_error(
            Error, 'Not found: Resource cannot be found')

        expect{ described_class.find(subcategory.id) }.to raise_error(
            Error, 'Not found: Resource cannot be found')

        new_cat.delete # keep things tidy
      end
    end

  end
end
