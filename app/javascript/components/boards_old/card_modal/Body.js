import React from 'react'
import Item from './item/Item'
import ToolBar from './ToolBar'
import PropTypes from 'prop-types'


export default class Body extends React.Component {
  constructor(props) {
    super(props)
  }

  render() {
    const {
      name,
      item_order,
      items
    } = this.props.card

    const {
      card,
      newItem,
      setItemEditing
    } = this.props
    
    return (
      <React.Fragment>
        <div>
          <h1>
            {name}
          </h1>
          <p>
          </p>
          <div
            className="card-items"
          >
            {item_order.map((uuid, index) =>
              <Item
                cardUuid={card.uuid}
                key={uuid}
                index={index}
                item={items[uuid]}
                newItem={newItem}
                setItemEditing={setItemEditing}
                previousItem={items[item_order[index - 1]]}
              />
            )}
          </div>
        </div>
        <ToolBar
          newItem={newItem}
        />
      </React.Fragment>
    )
  }
}

Body.propTypes = {
  card:           PropTypes.object.isRequired,
  newItem:        PropTypes.func.isRequired,
  setItemEditing: PropTypes.func.isRequired
}