import React from "react"
import Property from "./Property"
import UploadButton from "./UploadButton"

const PropertyList = (props) => {
  const { properties, total_count } = props

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

  const emptySection = (
    <div className="property-list-empty">
      <h3>No Properties Found</h3>
      <p>There are currently no properties to display. Import some properties to get started.</p>
    </div>
  )

  const tableSection = (
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
  )

  return (
    <div className="property-list-container">
      <div className="property-list-header">
        <div className="property-list-info">
          <h1 className="property-list-title">Property List</h1>
          <span className="property-list-count">{total_count} properties found</span>
        </div>
        <UploadButton />
      </div>
      {properties.length === 0 ? emptySection : tableSection}
    </div>
  )
}

export default PropertyList
