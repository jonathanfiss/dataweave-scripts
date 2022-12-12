%dw 2.0
output application/json
---
payload  update {
        case pending at .pending ->  pending map ((item, index) -> item  update {
                case amout at .amount -> amout/100
                case fee at .fee -> fee/100
        })
}