%dw 2.0
output application/json
---
{
    noRounding: 0.456,
    roundUP: 0.456 as String { format: "0.00" },
    roundUP: 0.456 as String { format: "0.0" },
    double: 1234.56 as String,
    double1: 1234.56 as Number as String { format: "#,###" },
    double2: (1234.56 + 0.2) as Number as String { format: "#" },
    double3: 1234.56 as Number as String { format: "#,###.00" },
    double4: 1234.56 as Number as String { format: "#,###.##" },
    double5: 1234.56 as Number as String { format: "#,###.###" },
        // comment: java.lang.Integer only works with strings or int, not double (decimal),
    double6: 1234.56 as Number { class: "java.lang.Integer" } as String { format: "#,###.000" },
    int: 12345 as String,
    int1: 12345 as Number as String { format: "#,###" },
    int2: 12345 as Number as String { format: "#,###.##" },
    int3: 12345 as Number as String { format: "#,###.00" },
    int4: 12345 as Number as String { format: "#,###.000" },
    valueX: 123123456.709 as String,
        // round to integer
    valueX1: 123123456.709 as String { format: "\$#,###" },
    valueX1: 123123456.709 as String { format: "#,###.00#%" },
        // round to 2 decimal places
    valueX2: 123123456.709 as String { format: "#,##0.0#" },
        // round to 3 decimal places
    valueX3: 123123456.709 as String { format: "#,###.###" },
        // round to 4 decimal places
    valueX4: 123123456.709 as String { format: "#,###.0000" },
    valueX5: 123123456709 as String { format: "#,##" },
        // round to 3 decimal places, pad to 2 decimal places #,##0.00#
    valueY1: 789789780 as String { format: "#,##0.00#" },
        // round and pad to 3 decimal places #,###.000
    valueY2: 789789780 as String { format: "#,###.000" },
        // 0.7129 round and pad to 3 decimal places #,###.000
    valueY3: 0.7129 as String { format: "#,###.000" },
        // 0.7129 round and pad to 3 decimal places, format as 0.xxx #,##0.000
    valueY4: 0.7129 as String { format: "#,##0.000" },
}