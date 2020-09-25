module Cards
  class ShowPresenter < BasePresenter
    attr_reader :card

    def initialize(card)
      @card = card
    end

    def to_h
      {
        card: {
          item_order: card.card_items.ordered.pluck(:uuid),
          items: card_items,
          name: card.name,
          number: card.card_number,
          short_name: card.name.truncate(34),
          uuid: card.uuid
        }
      }
    end

    private  def card_items
      items = {}

      card.card_items.each do |card_item|
        author = card_item.author

        items[card_item.uuid] = {
          type: card_item.item_type,
          author_name: author&.name,
          author_avatar: author&.avatar_path,
          params: card_item.formatted_item,
          uuid: card_item.uuid
        }
      end

      items
    end
  end
end