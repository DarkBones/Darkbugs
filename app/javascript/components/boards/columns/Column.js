import React          from 'react'
import PropTypes      from 'prop-types'
import Title          from './title/Title'
import { Draggable }  from 'react-beautiful-dnd'

export default function Column(props) {
  const {
    column,
    deleteColumn,
    index,
    updateColumnName,
    userIsAssigned,
    uuid
  } = props

  return (
    <Draggable
      draggableId=    {uuid}
      index=          {index}
      isDragDisabled= {!userIsAssigned}
    >
      {(provided) => (
        <div
          ref={provided.innerRef}
          {...provided.draggableProps}
        >
          <div className="column rounded">
            <div
              className="column-title"
              {...provided.dragHandleProps}
            >
              <Title
                columnUuid=       {uuid}
                deleteColumn=     {deleteColumn}
                name=             {column.name}
                updateColumnName= {updateColumnName}
                userIsAssigned=   {userIsAssigned}
              />
            </div>
          </div>
        </div>
      )}
    </Draggable>
  )
}

Column.propTypes = {
  column:           PropTypes.object.isRequired,
  deleteColumn:     PropTypes.func.isRequired,
  index:            PropTypes.number.isRequired,
  updateColumnName: PropTypes.func.isRequired,
  userIsAssigned:   PropTypes.bool.isRequired,
  uuid:             PropTypes.string.isRequired
}