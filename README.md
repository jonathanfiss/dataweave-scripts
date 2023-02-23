# DataWeave Scripts

## Table of Contents

**Commons Scripts**
- [DataWeave Scripts](#dataweave-scripts)
  - [Table of Contents](#table-of-contents)
  - [Commons Scripts](#commons-scripts)
    - [groupBy](#groupby)
    - [groupBy Multi Values ValueOf](#groupby-multi-values-valueof)
    - [Map MapObject FlatMap Flatten](#map-mapobject-flatmap-flatten)
    - [number Must Have Zero After Dot](#number-must-have-zero-after-dot)
    - [update Specific Attribute In Array](#update-specific-attribute-in-array)
    - [first and last day of the month](#first-and-last-day-of-the-month)
  - [number coercions](#number-coercions)
    - [format](#format)
    - [roundMode](#roundmode)
    - [date coercions](#date-coercions)
    - [size Of Payload](#size-of-payload)

**Coercions**
- [number coercions](#number-coercions)
- [date coercions](#date-coercions)

## Commons Scripts

### groupBy

<small>Tags: <kbd>groupBy</kbd></small>

<a href="https://dataweave.mulesoft.com/learn/playground?projectMethod=GHRepo&repo=jonathanfiss%2Fdataweave-scripts&path=scripts%2FgroupBy"><img width="300" src="/images/dwplayground-button.png"><a>

<details>
  <summary>Input</summary>

  ```json
  [
    {
        "dateMovement": "2021-06-07T00:00:00-03:00",
        "descriptionExtract": "Payment",
        "value": 24546.74,
        "typeMovement": "A"
    },
    {
        "dateMovement": "2021-06-07T00:00:00-03:00",
        "descriptionExtract": "Payment",
        "value": 24588.46,
        "typeMovement": "D"
    },
    {
        "dateMovement": "2021-06-09T00:00:00-03:00",
        "descriptionExtract": "Payment",
        "value": 2559.38,
        "typeMovement": "A"
    },
    {
        "dateMovement": "2021-06-10T00:00:00-03:00",
        "descriptionExtract": "Payment",
        "value": 2559.38,
        "typeMovement": "D"
    }
]
  ```

</details>

<details>
  <summary>Script</summary>

  ```dataweave
 %dw 2.0
output application/json  
---
{
  releases: (payload groupBy ((item, index) -> item.dateMovement) mapObject ((value, key) -> 
    group: {
      dataReference: key,
      detailsLaunch: value map ((item, index) -> {
        description: item.descriptionExtract,
        value: item.value,
        typeMovement: item.typeMovement
      })
    }
  )).*group
}
  ```

</details>

<details>
  <summary>Output</summary>

  ```json
  {
    "releases": [
      {
        "dataReference": "2021-06-07T00:00:00-03:00",
        "detailsLaunch": [
          {
            "description": "Payment",
            "value": 24546.74,
            "typeMovement": "A"
          },
          {
            "description": "Payment",
            "value": 24588.46,
            "typeMovement": "D"
          }
        ]
      },
      {
        "dataReference": "2021-06-09T00:00:00-03:00",
        "detailsLaunch": [
          {
            "description": "Payment",
            "value": 2559.38,
            "typeMovement": "A"
          }
        ]
      },
      {
        "dataReference": "2021-06-10T00:00:00-03:00",
        "detailsLaunch": [
          {
            "description": "Payment",
            "value": 2559.38,
            "typeMovement": "D"
          }
        ]
      }
    ]
  }
  ```

</details>

### groupBy Multi Values ValueOf

<small>Tags: <kbd>groupBy</kbd> <kbd>valueOf</kbd></small>

<a href="https://dataweave.mulesoft.com/learn/playground?projectMethod=GHRepo&repo=jonathanfiss%2Fdataweave-scripts&path=scripts%2FgroupByMultiValuesValueOf"><img width="300" src="/images/dwplayground-button.png"><a>

<details>
  <summary>Input</summary>

  ```json
[
    {
        "item": 621,
        "orderid": "ON22",
        "qty": 45.0,
        "customer": "813",
        "date": "1988-08-13"
    },
  {
        "item": 63,
        "orderid": "ON22",
        "qty": 7,
        "customer": "813",
        "date": "2001-08-13"
    },
 {
        "item": 54,
        "orderid": "AD546",
        "qty": 9,
        "customer": "813",
        "date": "2014-08-13"
    },
   {
        "item": 611,
        "orderid": "ON222723-JH",
        "qty": 78.0,
        "customer": "890",
        "date": "1990-05-11"
    }
]
  ```

</details>

<details>
  <summary>Script</summary>

  ```dataweave
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
  ```

</details>

<details>
  <summary>Output</summary>

  ```json
[
  {
    "customer": "813",
    "orderid": "ON22",
    "data": [
      {
        "item": 621,
        "qty": 45,
        "date": "1988-08-13"
      },
      {
        "item": 63,
        "qty": 7,
        "date": "2001-08-13"
      }
    ]
  },
  {
    "customer": "813",
    "orderid": "AD546",
    "data": [
      {
        "item": 54,
        "qty": 9,
        "date": "2014-08-13"
      }
    ]
  },
  {
    "customer": "890",
    "orderid": "ON222723-JH",
    "data": [
      {
        "item": 611,
        "qty": 78,
        "date": "1990-05-11"
      }
    ]
  }
]
  ```

</details>

### Map MapObject FlatMap Flatten

<small>Tags: <kbd>map</kbd> <kbd>mapObject</kbd> <kbd>flatMap</kbd> <kbd>flatten</kbd></small>

<a href="https://dataweave.mulesoft.com/learn/playground?projectMethod=GHRepo&repo=jonathanfiss%2Fdataweave-scripts&path=scripts%2FmapMapObjectFlatMapFlatten"><img width="300" src="/images/dwplayground-button.png"><a>

<details>
  <summary>Input</summary>

  ```json
[
  {
    "options": [
      {
        "modality": "0101",
        "LinkEM": "N",
        "options": [
          {
            "110": "10.31"
          }
        ]
      },
      {
        "modality": "0216",
        "LinkEM": "N",
        "salaries": [
          {
            "110": "4609.40",
            "120": "4554.65",
            "130": "4492.05",
            "140": "13133.82",
            "150": "24801.09",
            "160": "44238.70",
            "165": "37894.92",
            "170": "5769.20"
          }
        ]
      },
      {
        "modality": "0299",
        "LinkEM": "N",
        "salaries": [
          {
            "110": "4801.36",
            "120": "2966.25",
            "130": "2966.25",
            "140": "7063.64",
            "150": "13700.26"
          }
        ]
      },
      {
        "modality": "1904",
        "LinkEM": "N",
        "salaries": [
          {
            "40": "2000.00"
          }
        ]
      }
    ],
    "idPerson": "3dc19c13-445d-46eb-9255-137b190229ac",
    "idPersonCRS": 598
  },
  {
    "options": [
      {
        "modality": "0216",
        "LinkEM": "N",
        "salaries": [
          {
            "110": "11790.77",
            "120": "11754.23",
            "130": "11718.25",
            "140": "34944.40",
            "150": "68990.52",
            "160": "51719.49",
            "165": "23170.77"
          }
        ]
      },
      {
        "modality": "1350",
        "LinkEM": "N",
        "salaries": [
          {
            "110": "837.02"
          }
        ]
      },
      {
        "modality": "1902",
        "LinkEM": "N",
        "salaries": [
          {
            "20": "53200.00"
          }
        ]
      },
      {
        "modality": "1904",
        "LinkEM": "N",
        "salaries": [
          {
            "40": "45000.00"
          }
        ]
      }
    ],
    "idPerson": "681d032c-6023-4a3b-96e4-21f0add95d1b",
    "idPersonCRS": 254
  }
]
  ```

</details>

<details>
  <summary>Script</summary>

  ```dataweave
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
  ```

</details>

<details>
  <summary>Output</summary>

  ```json
 [
  {
    "idPersonCRS": 598,
    "modality": "0216",
    "LinkEM": "N",
    "cdSalaries": "110",
    "vlSalaries": "4609.40"
  },
  {
    "idPersonCRS": 598,
    "modality": "0216",
    "LinkEM": "N",
    "cdSalaries": "120",
    "vlSalaries": "4554.65"
  },
  {
    "idPersonCRS": 598,
    "modality": "0216",
    "LinkEM": "N",
    "cdSalaries": "130",
    "vlSalaries": "4492.05"
  },
  {
    "idPersonCRS": 598,
    "modality": "0216",
    "LinkEM": "N",
    "cdSalaries": "140",
    "vlSalaries": "13133.82"
  },
  {
    "idPersonCRS": 598,
    "modality": "0216",
    "LinkEM": "N",
    "cdSalaries": "150",
    "vlSalaries": "24801.09"
  },
  {
    "idPersonCRS": 598,
    "modality": "0216",
    "LinkEM": "N",
    "cdSalaries": "160",
    "vlSalaries": "44238.70"
  },
  {
    "idPersonCRS": 598,
    "modality": "0216",
    "LinkEM": "N",
    "cdSalaries": "165",
    "vlSalaries": "37894.92"
  },
  {
    "idPersonCRS": 598,
    "modality": "0216",
    "LinkEM": "N",
    "cdSalaries": "170",
    "vlSalaries": "5769.20"
  },
  {
    "idPersonCRS": 598,
    "modality": "0299",
    "LinkEM": "N",
    "cdSalaries": "110",
    "vlSalaries": "4801.36"
  },
  {
    "idPersonCRS": 598,
    "modality": "0299",
    "LinkEM": "N",
    "cdSalaries": "120",
    "vlSalaries": "2966.25"
  },
  {
    "idPersonCRS": 598,
    "modality": "0299",
    "LinkEM": "N",
    "cdSalaries": "130",
    "vlSalaries": "2966.25"
  },
  {
    "idPersonCRS": 598,
    "modality": "0299",
    "LinkEM": "N",
    "cdSalaries": "140",
    "vlSalaries": "7063.64"
  },
  {
    "idPersonCRS": 598,
    "modality": "0299",
    "LinkEM": "N",
    "cdSalaries": "150",
    "vlSalaries": "13700.26"
  },
  {
    "idPersonCRS": 598,
    "modality": "1904",
    "LinkEM": "N",
    "cdSalaries": "40",
    "vlSalaries": "2000.00"
  },
  {
    "idPersonCRS": 254,
    "modality": "0216",
    "LinkEM": "N",
    "cdSalaries": "110",
    "vlSalaries": "11790.77"
  },
  {
    "idPersonCRS": 254,
    "modality": "0216",
    "LinkEM": "N",
    "cdSalaries": "120",
    "vlSalaries": "11754.23"
  },
  {
    "idPersonCRS": 254,
    "modality": "0216",
    "LinkEM": "N",
    "cdSalaries": "130",
    "vlSalaries": "11718.25"
  },
  {
    "idPersonCRS": 254,
    "modality": "0216",
    "LinkEM": "N",
    "cdSalaries": "140",
    "vlSalaries": "34944.40"
  },
  {
    "idPersonCRS": 254,
    "modality": "0216",
    "LinkEM": "N",
    "cdSalaries": "150",
    "vlSalaries": "68990.52"
  },
  {
    "idPersonCRS": 254,
    "modality": "0216",
    "LinkEM": "N",
    "cdSalaries": "160",
    "vlSalaries": "51719.49"
  },
  {
    "idPersonCRS": 254,
    "modality": "0216",
    "LinkEM": "N",
    "cdSalaries": "165",
    "vlSalaries": "23170.77"
  },
  {
    "idPersonCRS": 254,
    "modality": "1350",
    "LinkEM": "N",
    "cdSalaries": "110",
    "vlSalaries": "837.02"
  },
  {
    "idPersonCRS": 254,
    "modality": "1902",
    "LinkEM": "N",
    "cdSalaries": "20",
    "vlSalaries": "53200.00"
  },
  {
    "idPersonCRS": 254,
    "modality": "1904",
    "LinkEM": "N",
    "cdSalaries": "40",
    "vlSalaries": "45000.00"
  }
]
  ```

</details>

### number Must Have Zero After Dot

<small>Tags: <kbd>java</kbd> <kbd>double</kbd></small>

adds zero when number is integer and has no decimal part. [Doc java Double](https://docs.oracle.com/javase/8/docs/api/java/lang/Double.html)

<a href="https://dataweave.mulesoft.com/learn/playground?projectMethod=GHRepo&repo=jonathanfiss%2Fdataweave-scripts&path=scripts%2FnumberMustHaveZeroAfterDot"><img width="300" src="/images/dwplayground-button.png"><a>



<details>
  <summary>Input</summary>

  ```json
{
  "amount": 123
}
  ```

</details>

<details>
  <summary>Script</summary>

  ```dataweave
%dw 2.0
import java!java::lang::Double
output application/json
---
Double::parseDouble(payload.amount)
  ```

</details>

<details>
  <summary>Output</summary>

  ```json
123.0
  ```

</details>

### update Specific Attribute In Array

<small>Tags: <kbd>update</kbd> <kbd>array</kbd></small>

<a href="https://dataweave.mulesoft.com/learn/playground?projectMethod=GHRepo&repo=jonathanfiss%2Fdataweave-scripts&path=scripts%2FupdateSpecificAttributeInArray"><img width="300" src="/images/dwplayground-button.png"><a>

<details>
  <summary>Input</summary>

  ```json
{
    "pending": [
        {
            "amount": 100,
            "fee": 500
        },
        {
            "amount": 123,
            "fee": 500
        }
    ],
    "x": 1
}
  ```

</details>

<details>
  <summary>Script</summary>

  ```dataweave
%dw 2.0
output application/json
---
payload  update {
        case pending at .pending ->  pending map ((item, index) -> item  update {
                case amout at .amount -> amout/100
                case fee at .fee -> fee/100
        })
}
  ```

</details>

<details>
  <summary>Output</summary>

  ```json
{
  "pending": [
    {
      "amount": 1,
      "fee": 5
    },
    {
      "amount": 1.23,
      "fee": 5
    }
  ],
  "x": 1
}
  ```

</details>

### first and last day of the month

<small>Tags: <kbd>date</kbd></small>

<a href="https://dataweave.mulesoft.com/learn/playground?projectMethod=GHRepo&repo=jonathanfiss%2Fdataweave-scripts&path=scripts%2FfirstAndLastDayOfMonth"><img width="300" src="/images/dwplayground-button.png"><a>

<details>
  <summary>Input</summary>

  ```json
{
    "date": "2023-02-15"
}
  ```

</details>

<details>
  <summary>Script</summary>

  ```dataweave
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
  ```

</details>

<details>
  <summary>Output</summary>

  ```json
{
  "firstDateOfMonth": "2023-02-01",
  "LastDateOfMonth": "2023-02-28"
}
  ```

</details>

## number coercions

### format

<small>Tags: <kbd>number</kbd> <kbd>coercions</kbd> <kbd>format</kbd></small>

<a href="https://dataweave.mulesoft.com/learn/playground?projectMethod=GHRepo&repo=jonathanfiss%2Fdataweave-scripts&path=scripts%2FnumberCoercions%2Fformat"><img width="300" src="/images/dwplayground-button.png"><a>

<details>
  <summary>Script</summary>

  ```dataweave
%dw 2.0
output application/json
---
{
        noRounding: 0.456,
        roundUP: 0.456 as String {format: "0.00"},
        roundUP: 0.456 as String {format: "0.0"},
        double: 1234.56 as String,
        double1: 1234.56 as Number as String {format: "#,###"},
        double2: (1234.56 + 0.2) as Number as String {format: "#"},
        double3: 1234.56 as Number as String {format: "#,###.00"},
        double4: 1234.56 as Number as String {format: "#,###.##"},
        double5: 1234.56 as Number as String {format: "#,###.###"},
        // comment: java.lang.Integer only works with strings or int, not double (decimal),
        double6: 1234.56 as Number {class: "java.lang.Integer"} as String {format: "#,###.000"},
        int: 12345 as String,
        int1: 12345 as Number as String {format: "#,###"},
        int2: 12345 as Number as String {format: "#,###.##"},
        int3: 12345 as Number as String {format: "#,###.00"},
        int4: 12345 as Number as String {format: "#,###.000"},
        valueX: 123123456.709 as String,
        // round to integer
        valueX1: 123123456.709 as String {format: "\$#,###"},
        valueX1: 123123456.709 as String {format: "#,###.00#%"},
        // round to 2 decimal places
        valueX2: 123123456.709 as String {format: "#,##0.0#"},
        // round to 3 decimal places
        valueX3: 123123456.709 as String {format: "#,###.###"},
        // round to 4 decimal places
        valueX4: 123123456.709 as String {format: "#,###.0000"},
        valueX5: 123123456709 as String {format: "#,##"},
        // round to 3 decimal places, pad to 2 decimal places #,##0.00#
        valueY1: 789789780 as String {format: "#,##0.00#"},
        // round and pad to 3 decimal places #,###.000
        valueY2: 789789780 as String {format: "#,###.000"},
        // 0.7129 round and pad to 3 decimal places #,###.000
        valueY3: 0.7129 as String {format: "#,###.000"},
        // 0.7129 round and pad to 3 decimal places, format as 0.xxx #,##0.000
        valueY4: 0.7129 as String {format: "#,##0.000"},
}
  ```

</details>

<details>
  <summary>Output</summary>

  ```json
{
    "noRounding": 0.456,
    "roundUP": "0.46",
    "roundUP": "0.5",
    "double": "1234.56",
    "double1": "1,235",
    "double2": "1235",
    "double3": "1,234.56",
    "double4": "1,234.56",
    "double5": "1,234.56",
    "double6": "1,234.560",
    "int": "12345",
    "int1": "12,345",
    "int2": "12,345",
    "int3": "12,345.00",
    "int4": "12,345.000",
    "valueX": "123123456.709",
    "valueX1": "$123,123,457",
    "valueX1": "12,312,345,670.90%",
    "valueX2": "123,123,456.71",
    "valueX3": "123,123,456.709",
    "valueX4": "123,123,456.7090",
    "valueX5": "12,31,23,45,67,09",
    "valueY1": "789,789,780.00",
    "valueY2": "789,789,780.000",
    "valueY3": ".713",
    "valueY4": "0.713"
  }
  ```

</details>

### roundMode

<small>Tags: <kbd>number</kbd> <kbd>coercions</kbd> <kbd>roundMode</kbd></small>

[number coercions functions tostring](https://docs.mulesoft.com/dataweave/2.4/dw-coercions-functions-tostring#tostring1)

> .
>| Name      | Description |
>| ----------- | ----------- |
>| number      | The Number value to format. |
>| format      | The formatting to apply to the Number value. A format accepts `#` or `0` (but not both) as placeholders for decimal values, and only one decimal point is permitted. A null or empty String value has no effect on the Number value. Most other values are treated as literals, but you must escape special characters, such as a dollar sign (for example, `\$`). Inner quotations must be closed and differ from the surrounding quotations.        |
>| roundMode   | Optional parameter for rounding decimal values when the formatting presents a rounding choice, such as a format of `0.#` for the decimal `0.15`. The default is HALF_UP, and a null value returns behaves like HALF_UP. Only one of the following values is permitted:  <ul><li>**UP**: Always rounds away from zero (for example, `0.01` to `"0.1"` and `-0.01` to `"-0.1"`). Increments the preceding digit to a non-zero fraction and never decreases the magnitude of the calculated value.</li><li>**DOWN**: Always rounds towards zero (for example, `0.19` to `"0.1"` and `-0.19` to `"-0.1"`). Never increments the digit before a discarded fraction (which truncates to the preceding digit) and never increases the magnitude of the calculated value.</li><li>**CEILING**: Rounds towards positive infinity and behaves like UP if the result is positive (for example, `0.35` to `"0.4"`). If the result is negative, this mode behaves like DOWN (for example, `-0.35` to `"-0.3"`). This mode never decreases the calculated value.</li><li>**FLOOR**: Rounds towards negative infinity and behaves like DOWN if the result is positive (for example, `0.35` to `"0.3"`). If the result is negative, this mode behaves like UP (for example, `-0.35` to `"-0.4"`). The mode never increases the calculated value.</li><li>**HALF_UP**: Default mode, which rounds towards the nearest "neighbor" unless both neighbors are equidistant, in which case, this mode rounds up. For example, `0.35` rounds to `"0.4"`, `0.34` rounds to `"0.3"`, and `0.36` rounds to `"0.4"`. Negative decimals numbers round similarly. For example, `-0.35` rounds to `"-0.4"`.</li><li>**HALF_DOWN**: Rounds towards the nearest numeric "neighbor" unless both neighbors are equidistant, in which case, this mode rounds down. For example, `0.35` rounds to `"0.3"`, `0.34` rounds to `"0.3"`, and `0.36` rounds to `"0.4"`. Negative decimals numbers round similarly. For example, `-0.35` rounds to `"-0.3"`.</li><li>**HALF_EVEN**: For decimals that end in a 5 (such as, `1.125` and `1.135`), the behavior depends on the number that precedes the 5. HALF_EVEN rounds up when the next-to-last digit before the 5 is an odd number but rounds down when the next-to-last digit is even. For example, `0.225` rounds to "0.22", 0.235 and 0.245 round to "0.24", and 0.255 rounds to "0.26". Negative decimals round similarly, for example, `-0.225` to `"-0.22"`. When the last digit is not 5, the setting behaves like HALF_UP. Rounding of monetary values sometimes follows the HALF_EVEN pattern.</li></ul>      |
> .
<p style="text-align:right"><a href="https://docs.mulesoft.com/dataweave/2.4/dw-coercions-functions-tostring#parameters">Reference Mulesoft<a></p>


<a href="https://dataweave.mulesoft.com/learn/playground?projectMethod=GHRepo&repo=jonathanfiss%2Fdataweave-scripts&path=scripts%2FnumberCoercions%2FroundMode"><img width="300" src="/images/dwplayground-button.png"><a>


<details>
  <summary>Script</summary>

  ```dataweave
%dw 2.0
output application/json
---
{
        // round DOWN
        roundDownP: 0.456 as String {format: "0.00", roundMode:"DOWN"},
        roundDownN: -0.456 as String {format: "0.00", roundMode:"DOWN"},
        // round UP
        roundUPP: 0.454 as String {format: "0.00", roundMode:"UP"},
        roundUPN: -0.454 as String {format: "0.00", roundMode:"UP"},
        // round CEILING
        roundCeilingP: 0.456 as String {format: "0.00", roundMode:"CEILING"},
        roundCeilingN: -0.456 as String {format: "0.00", roundMode:"CEILING"},
        // round FLOOR
        roundFloorP: 0.456 as String {format: "0.00", roundMode:"FLOOR"},
        roundFloorN: -0.456 as String {format: "0.00", roundMode:"FLOOR"},
        // round HALF_DOWN
        roundHalfDownP: 0.456 as String {format: "0.00", roundMode:"HALF_DOWN"},
        roundHalfDownN: 0.455 as String {format: "0.00", roundMode:"HALF_DOWN"},
        // round HALF_EVEN
        roundHalfEvenP: 0.455 as String {format: "0.00", roundMode:"HALF_EVEN"},
        roundHalfEvenN: 0.454 as String {format: "0.00", roundMode:"HALF_EVEN"},
        // round HALF_UP
        roundHalfUpPI: 0.455 as String {format: "0.00", roundMode:"HALF_UP"},
        roundHalfUpPD: 0.454 as String {format: "0.00", roundMode:"HALF_UP"},
        roundHalfUpND: -0.454 as String {format: "0.00", roundMode:"HALF_UP"},
        roundHalfUpNI: -0.455 as String {format: "0.00", roundMode:"HALF_UP"},
}
  ```

</details>

<details>
  <summary>Output</summary>

  ```json
{
    "roundDownP": "0.45",
    "roundDownN": "-0.45",
    "roundUPP": "0.46",
    "roundUPN": "-0.46",
    "roundCeilingP": "0.46",
    "roundCeilingN": "-0.45",
    "roundFloorP": "0.45",
    "roundFloorN": "-0.46",
    "roundHalfDownP": "0.46",
    "roundHalfDownN": "0.45",
    "roundHalfEvenP": "0.46",
    "roundHalfEvenN": "0.45",
    "roundHalfUpPI": "0.46",
    "roundHalfUpPD": "0.45",
    "roundHalfUpND": "-0.45",
    "roundHalfUpNI": "-0.46"
  }
  ```

</details>

### date coercions

<small>Tags: <kbd>date</kbd> <kbd>coercions</kbd></small>

<a href="https://dataweave.mulesoft.com/learn/playground?projectMethod=GHRepo&repo=jonathanfiss%2Fdataweave-scripts&path=scripts%2FdateCoercions"><img width="300" src="/images/dwplayground-button.png"><a>

<details>
  <summary>Input</summary>

  ```json
{
    "pending": [
        {
            "amount": 100,
            "fee": 500
        },
        {
            "amount": 123,
            "fee": 500
        }
    ],
    "x": 1
}
  ```

</details>

<details>
  <summary>Script</summary>

  ```dataweave
%dw 2.0
output application/json
---
payload  update {
        case pending at .pending ->  pending map ((item, index) -> item  update {
                case amout at .amount -> amout/100
                case fee at .fee -> fee/100
        })
}
  ```

</details>

<details>
  <summary>Output</summary>

  ```json
{
  "pending": [
    {
      "amount": 1,
      "fee": 5
    },
    {
      "amount": 1.23,
      "fee": 5
    }
  ],
  "x": 1
}
  ```

</details>

### size Of Payload

<small>Tags: <kbd>size</kbd></small>

<a href="https://dataweave.mulesoft.com/learn/playground?projectMethod=GHRepo&repo=jonathanfiss%2Fdataweave-scripts&path=scripts%2FsizeOfPayload"><img width="300" src="/images/dwplayground-button.png"><a>



<details>
  <summary>Input</summary>

  ```json
{
  "squadName": "Super hero squad",
  "homeTown": "Metro City",
  "formed": 2016,
  "secretBase": "Super tower",
  "active": true,
  "members": [
    {
      "name": "Molecule Man",
      "age": 29,
      "secretIdentity": "Dan Jukes",
      "powers": ["Radiation resistance", "Turning tiny", "Radiation blast"]
    },
    {
      "name": "Madame Uppercut",
      "age": 39,
      "secretIdentity": "Jane Wilson",
      "powers": [
        "Million tonne punch",
        "Damage resistance",
        "Superhuman reflexes"
      ]
    },
    {
      "name": "Eternal Flame",
      "age": 1000000,
      "secretIdentity": "Unknown",
      "powers": [
        "Immortality",
        "Heat Immunity",
        "Inferno",
        "Teleportation",
        "Interdimensional travel"
      ]
    }
  ]
}

  ```

</details>

<details>
  <summary>Script</summary>

  ```dataweave
%dw 2.0
output application/json
var content = write(payload, 'application/json', {indent: true})
var size = sizeOf(content) / 1024
---
(size as String {format: '#.00'} ++ ' KB')
  ```

</details>

<details>
  <summary>Output</summary>

  ```json
".81 KB"
  ```

</details>
