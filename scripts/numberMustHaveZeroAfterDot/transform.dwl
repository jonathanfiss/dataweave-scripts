%dw 2.0
import java!java::lang::Double
output application/json
---
Double::parseDouble(payload.amount)