%dw 2.0
output application/json
import between from dw::core::Periods

var age = between(now() as Date, payload.dateToCalculate as Date)
---
{   
    "years" : age.years,
    "months": age.months,
    "days": age.days   
}