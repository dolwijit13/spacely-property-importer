import React from "react"

const Property = (props) => {
  const { unique_id, name, address, room_number, rent, size, property_type, created_at } = props

  return (
    <tr>
      <td>{unique_id}</td>
      <td>{name}</td>
      <td>{address}</td>
      <td>{room_number}</td>
      <td>{rent}</td>
      <td>{size}</td>
      <td>{property_type}</td>
      <td>{created_at}</td>
    </tr>
  )
}

export default Property
