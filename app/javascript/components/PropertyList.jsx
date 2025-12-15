import React from "react"
import Property from "./Property"

const PropertyList = (props) => {
  const { properties } = props

  const headers = [
    "Unique ID",
    "Name",
    "Address",
    "Rooms",
    "Rent",
    "Size",
    "Type",
    "Created At"
  ]

  if (!properties || properties.length === 0) {
    return (
      <div>
        <h1>Property List</h1>
        <div>
          <h3>No Properties Found</h3>
          <p>There are currently no properties to display. Import some properties to get started.</p>
        </div>
      </div>
    )
  }

  return (
    <div>
      <h1>Property List</h1>
      <table>
        <thead>
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
