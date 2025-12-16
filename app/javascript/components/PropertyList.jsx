import React from "react"
import Property from "./Property"

const PropertyList = (props) => {
  const { properties } = props

  const headers = [
    "ユニークID",
    "物件名",
    "住所",
    "部屋番号",
    "賃料",
    "広さ",
    "建物の種類",
    "作成日時"
  ]

  if (!properties || properties.length === 0) {
    return (
      <div className="property-list-container">
        <h1 className="property-list-title">Property List</h1>
        <div className="property-list-empty">
          <h3>No Properties Found</h3>
          <p>There are currently no properties to display. Import some properties to get started.</p>
        </div>
      </div>
    )
  }

  return (
    <div className="property-list-container">
      <h1 className="property-list-title">Property List</h1>
      <table className="property-table">
        <thead className="property-table-header">
          <tr>
            {headers.map((header) => (
              <th key={header}>{header}</th>
            ))}
          </tr>
        </thead>
        <tbody>
          {properties.map((property) => (
            <Property key={property.id} {...property} />
          ))}
        </tbody>
      </table>
    </div>
  )
}

export default PropertyList
