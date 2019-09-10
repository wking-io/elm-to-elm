import React from "react"

export const YoutubeVideo = ({ videoId, className = "" }) => {
  return (
    <div
      className={`relative h-0 ${className}`}
      style={{
        paddingBottom: "56.25%",
      }}
    >
      <iframe
        title="Youtube embed"
        className="absolute top-0 left-0 w-full h-full"
        src={`https://www.youtube.com/embed/${videoId}`}
        frameBorder="0"
      />
    </div>
  )
}
