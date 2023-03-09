%dw 2.0
type typesUnitMeasure = 'B' | 'KB' | 'MB' | 'GB' | 'TB' | 'PB' | 'EB' | 'ZB' | 'YB'

fun formatUnitsMeasureComputation(value: Number, inputUnitMeasure: typesUnitMeasure, outputUnitMeasure: typesUnitMeasure, displayUnitMeasure = false) =
  if (value > 0)
    do {
      var valueInput = inputUnitMeasure match {
        case "B" -> value
        case "KB" -> value * 1024
        case "MB" -> value * (1024 pow 2)
        case "GB" -> value * (1024 pow 3)
        case "TB" -> value * (1024 pow 4)
        case "PB" -> value * (1024 pow 5)
        case "EB" -> value * (1024 pow 6)
        case "ZB" -> value * (1024 pow 7)
        case "YB" -> value * (1024 pow 8)
      }
      var valueOutput = outputUnitMeasure match {
        case "B" -> valueInput
        case "KB" -> valueInput / 1024
        case "MB" -> valueInput / (1024 pow 2)
        case "GB" -> valueInput / (1024 pow 3)
        case "TB" -> valueInput / (1024 pow 4)
        case "PB" -> valueInput / (1024 pow 5)
        case "EB" -> valueInput / (1024 pow 6)
        case "ZB" -> valueInput / (1024 pow 7)
        case "YB" -> valueInput / (1024 pow 8)
      }
      var round = valueOutput as String {format: '0.00'}
      ---
      if (displayUnitMeasure)
        round ++ " " ++ outputUnitMeasure as String
      else
        round as Number
    }
  else
    0
output application/json  
---
// formatUnitsMeasureComputation(13486197309440000, "B", "PB")
{
    "BtoKB": formatUnitsMeasureComputation(payload.BtoKB, "B", "KB"),
    "BtoMB": formatUnitsMeasureComputation(payload.BtoMB, "B", "MB", true),
    "BtoGB": formatUnitsMeasureComputation(payload.BtoGB, "B", "GB"),
    "BtoZB": formatUnitsMeasureComputation(payload.BtoZB, "B", "ZB"),
    "KBtoB": formatUnitsMeasureComputation(payload.KBtoB, "KB", "B"),
    "KBtoMB": formatUnitsMeasureComputation(payload.KBtoMB, "KB", "MB"),
    "KBtoGB": formatUnitsMeasureComputation(payload.KBtoGB,"KB", "GB", true),
    "MBtoB": formatUnitsMeasureComputation(payload.MBtoB,"MB", "B"),
    "MBtoKB": formatUnitsMeasureComputation(payload.MBtoKB,"MB", "KB"),
    "MBtoGB": formatUnitsMeasureComputation(payload.MBtoGB,"MB", "GB"),
    "GBtoB": formatUnitsMeasureComputation(payload.GBtoB,"GB", "B"),
    "GBtoKB": formatUnitsMeasureComputation(payload.GBtoKB,"GB", "KB", true),
    "GBtoMB": formatUnitsMeasureComputation(payload.GBtoMB,"GB", "MB"),
    "GBtoYB": formatUnitsMeasureComputation(payload.GBtoYB,"GB", "YB"),
    "TBtoGB": formatUnitsMeasureComputation(payload.TBtoGB,"TB", "GB"),
    "PBtoGB": formatUnitsMeasureComputation(payload.PBtoGB,"PB", "GB", true),
    "EBtoGB": formatUnitsMeasureComputation(payload.EBtoGB,"EB", "GB"),
    "ZBtoGB": formatUnitsMeasureComputation(payload.ZBtoGB,"ZB", "GB"),
    "YBtoGB": formatUnitsMeasureComputation(payload.YBtoGB,"YB", "GB")
}




