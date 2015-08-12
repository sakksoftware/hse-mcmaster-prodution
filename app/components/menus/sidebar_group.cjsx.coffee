# used for marking more than anything else
# no real funcionality beyond that
module.exports = React.createClass
  displayName: 'SidebarGroup'
  propTypes:
    children: React.PropTypes.array.isRequired

  render: ->
    <div className="sidebar-group">
    </div>
