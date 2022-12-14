%dw 2.0
output application/json
---
{
        // round DOWN
    roundDownP: 0.456 as String { format: "0.00", roundMode:"DOWN" },
    roundDownN: -0.456 as String { format: "0.00", roundMode:"DOWN" },
        // round UP
    roundUPP: 0.454 as String { format: "0.00", roundMode:"UP" },
    roundUPN: -0.454 as String { format: "0.00", roundMode:"UP" },
        // round CEILING
    roundCeilingP: 0.456 as String { format: "0.00", roundMode:"CEILING" },
    roundCeilingN: -0.456 as String { format: "0.00", roundMode:"CEILING" },
        // round FLOOR
    roundFloorP: 0.456 as String { format: "0.00", roundMode:"FLOOR" },
    roundFloorN: -0.456 as String { format: "0.00", roundMode:"FLOOR" },
        // round HALF_DOWN
    roundHalfDownP: 0.456 as String { format: "0.00", roundMode:"HALF_DOWN" },
    roundHalfDownN: 0.455 as String { format: "0.00", roundMode:"HALF_DOWN" },
        // round HALF_EVEN
    roundHalfEvenP: 0.455 as String { format: "0.00", roundMode:"HALF_EVEN" },
    roundHalfEvenN: 0.454 as String { format: "0.00", roundMode:"HALF_EVEN" },
        // round HALF_UP
    roundHalfUpPI: 0.455 as String { format: "0.00", roundMode:"HALF_UP" },
    roundHalfUpPD: 0.454 as String { format: "0.00", roundMode:"HALF_UP" },
    roundHalfUpND: -0.454 as String { format: "0.00", roundMode:"HALF_UP" },
    roundHalfUpNI: -0.455 as String { format: "0.00", roundMode:"HALF_UP" },
}