# useful for files

## output file name

```json
{
    "Content-Type" : "application/csv",
    "Content-Disposition": "attachment;filename=\"outputFileName.csv\""
}
```

## read csv with separator

```dataweave
%dw 2.0
input payload csv separator=";"
output application/json
---
payload
```