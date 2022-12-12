%dw 2.0
output application/json
---
flatten ((payload map (item, index) -> {
    mapPay : item.options map (itemOptions, indexOptions) -> {
        mapOp: itemOptions.salaries map (itemSalaries, indexSalaries) -> {
            mapVenc: itemSalaries mapObject (value, key, index) -> {
                mapValue: {
                    idPersonCRS: item.idPersonCRS,
                    modality: itemOptions.modality,
                    LinkEM: itemOptions.LinkEM,
                    cdSalaries: key,
                    vlSalaries: value
                }
            }
        }
    }
}) flatMap (valueFlat, index) -> valueFlat.mapPay.mapOp).*mapVenc.*mapValue