import React from "react"

const Property = (props) => {
  const { unique_id, name, address, room_number, rent, size, property_type, created_at } = props

  const formatRent = (rent) => {
    if (typeof rent === 'number') {
      return rent.toLocaleString()
    }
    return rent
  }

  const propertyTypeClass = (property_type) => {
    switch (property_type.toLowerCase()) {
      case 'アパート':
        return 'property-type-apartment'
      case '一戸建て':
        return 'property-type-house'
      case 'マンション':
        return 'property-type-condo'
      default:
        return 'property-type-other'
    }
  }

  return (
    <tr className="property-row">
      <td className="unique-id">{unique_id}</td>
      <td className="property-name">{name}</td>
      <td className="address" title={address}>{address}</td>
      <td className="room-number">{room_number}</td>
      <td className="rent">{formatRent(rent)}</td>
      <td className="size">{size}</td>
      <td>
        <div className={`${propertyTypeClass(property_type)} property-type`}>
          {property_type}
        </div>
      </td>
      <td className="created-at">
        {new Date(created_at).toLocaleString('en-CA', {
          year: 'numeric',
          month: '2-digit',
          day: '2-digit',
          hour: 'numeric',
          minute: '2-digit',
          hour12: false
        })}
      </td>
    </tr >
  )
}

export default Property
