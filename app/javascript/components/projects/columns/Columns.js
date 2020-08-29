import React from 'react'
import Column from './Column';
import AddColumnButton from './AddColumnButton';

export default class Columns extends React.Component {
  constructor(props) {
    super(props)

    this.state = {
      columns: props.columns
    }
  }

  addColumn = () => {
    let newColumns = {
      name: '',
      uuid: ''
    }

    if (JSON.stringify(this.state.columns) !== '{}') {
      newColumns = this.state.columns.concat(newColumns)
    }

    this.setState({
      columns: newColumns
    })
  }

  cancelNewColumns = () => {
    let persistedColumns = []

    this.state.columns.forEach(function (column) {
      if (column.uuid !== '') {
        persistedColumns.push(column)
      }
    })

    this.setState({
      columns: persistedColumns
    })
  }


  render() {
    return (
      <div
        id='columns'
      >
        {this.state.columns.map((column) =>
          <Column
            name={column.name}
            uuid={column.uuid}
            userIdAdmin={this.props.userIsAdmin}
            key={column.uuid}
            cancelNewColumns={this.cancelNewColumns}
          />
        )}
        <AddColumnButton
          handleClick={this.addColumn}
          userIsAdmin={this.props.userIsAdmin}
        />
      </div>
    )
  }
}
