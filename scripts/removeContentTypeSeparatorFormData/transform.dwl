%dw 2.0
output application/json
var content = write(payload, 'application/json', {indent: true})
var size = sizeOf(content) / 1024
---
(size as String {format: '#.00'} ++ ' KB')