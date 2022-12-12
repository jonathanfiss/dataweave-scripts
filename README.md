# DataWeave Scripts

## Table of Contents

## Commons Scripts

### groupBy

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

### Map MapObject FlatMap Flatten

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

<a href="https://dataweave.mulesoft.com/learn/playground?projectMethod=GHRepo&repo=jonathanfiss%2Fdataweave-scripts&path=scripts%2FnumberMustHaveZeroAfterDot"><img width="300" src="/images/dwplayground-button.png"><a>

https://docs.oracle.com/javase/8/docs/api/java/text/DecimalFormat.html

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

