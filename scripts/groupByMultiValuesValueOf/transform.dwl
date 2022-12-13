%dw 2.0
output application/json

// Concat customer and ordered as the key to group the items. Use a character that can't be part of any of the fields.
var groupedOrders = payload groupBy ((item, index) -> item.customer ++ "|" ++ item.orderid)
---
valuesOf(groupedOrders) map ((items, index) -> 
    {
        // I'm getting the first element as all in the items collection should have the same customer and orderid
        "customer": items[0].customer, 
        "orderid": items[0].orderid, 
        // The map here is just to remove the repeated fields
        "data": items map ((item, index) -> item - "customer" - "orderid")
    }
)