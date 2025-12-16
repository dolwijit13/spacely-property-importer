import React, { useRef } from "react"
import axios from "axios"
import { CSRF_TOKEN } from "../lib/helpers"

const UploadButton = () => {
  const fileInputRef = useRef(null)

  const handleUpload = () => {
    fileInputRef.current?.click()
  }

  const handleFileChange = (event) => {
    const file = event.target.files[0]
    if (file && file.type === 'text/csv') {
      const formData = new FormData();
      formData.append('file', file);
      formData.append('authenticity_token', CSRF_TOKEN)

      const headers = {
        'Accept': 'multipart/form-data'
      }

      axios({
        method: 'POST',
        url: '/api/properties/import',
        data: formData,
        headers: headers
      }).then(() => {
        alert('File uploaded successfully')
        window.location.reload()
      }).catch(() => {
        alert('Error uploading file')
        window.location.reload()
      })
    } else {
      alert('Please select a valid CSV file')
    }
  }

  return (
    <>
      <input
        type="file"
        ref={fileInputRef}
        onChange={handleFileChange}
        accept=".csv"
        className="upload-button-input"
      />
      <button className="upload-button" onClick={handleUpload}>
        Upload Properties
      </button>
    </>
  )
}

export default UploadButton
