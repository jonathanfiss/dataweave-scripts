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