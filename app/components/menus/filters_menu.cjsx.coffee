MenuToggle = require('components/menus/menu_toggle')

module.exports = React.createClass
  displayName: 'FiltersMenu'
  propTypes:
    onFilterClick: React.PropTypes.func.isRequired

  render: ->
    <div className="filters-menu">
      <h2>Topics of Interest</h2>
      <ul className="menu-list">
        <li className="menu-item"><span>Governance Arrangments</span></li>
        <li className="menu-item"><span>Financial Arrangements</span></li>
        <li className="menu-item"><span>Delivery Arrangments</span></li>
        <li className="menu-item"><span>Implementation Strategies</span></li>
      </ul>

      <h2>Domain</h2>
      <ul className="menu-list">
        <li className="menu-item"><span>Sectors</span></li>
        <li className="menu-item"><span>Providers</span></li>
        <li className="menu-item"><span>Technologies</span></li>
        <li className="menu-item"><span>Diseases</span></li>
      </ul>

      <h2>Area of Focus</h2>
      <ul className="menu-list">
        <li className="menu-item">
          <MenuToggle menu="countries" onToggle={@props.onFilterClick}>Countries</MenuToggle>
        </li>
        <li className="menu-item"><span>Country Groupings</span></li>
        <li className="menu-item"><span>WHO Regions</span></li>
        <li className="menu-item"><span>LMIC</span></li>
      </ul>

      <h2>Document Features</h2>
      <ul className="menu-list">
        <li className="menu-item"><span>Type</span></li>
        <li className="menu-item"><span>Free full-text</span></li>
        <li className="menu-item"><span>Date range</span></li>
        <li className="menu-item"><span>Focus</span></li>
        <li className="menu-item"><span>Target</span></li>
        <li className="menu-item"><span>Theme</span></li>
        <li className="menu-item"><span>Producer</span></li>
      </ul>

      <h2>Complementary Content</h2>
      <ul className="menu-list">
        <li className="menu-item"><span>Intergovermantal Orginizations' Health Systems Documents</span></li>
        <li className="menu-item"><span>Canada's Health System's Documents</span></li>
        <li className="menu-item"><span>Ontario's Health System's Documents</span></li>
      </ul>
    </div>