%dw 2.0
import dw::module::Multipart
input payload csv separator=';'
output multipart/form-data
---
Multipart::form([
  Multipart::field("file", payload, 'text/csv;separator=";"', "userInfo.csv")
])
