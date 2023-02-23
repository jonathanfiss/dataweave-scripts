%dw 2.0

fun firstDateOfMonth(value: Date): Date =
  (value as String {format: "yyyy-MM"} ++ "-01") as Date

fun lastDateOfMonth(value: Date): Date =
  (((value as String {format: "yyyy-MM"} ++ "-01") as Date {format: "yyyy-MM-dd"}) + |P1M| - |P1D|) as Date
output application/json  
---
{
  "firstDateOfCurrentMonth": firstDateOfMonth(payload.date),
  "LastDateOfCurrentMonth": lastDateOfMonth(payload.date)
}