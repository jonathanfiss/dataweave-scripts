%dw 2.0
input payload multipart
output multipart
---
{
  parts : {
    file: {
      headers : {
        "Content-Type": "text/csv",
        "Content-Disposition": payload.parts.file.headers."Content-Disposition"
      },
      content : payload.parts.file.content
    }
  }
}
