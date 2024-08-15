%dw 2.0
input payload multipart
output multipart
---
payload update {
  case .parts -> $ update {
    case .file -> $ update {
      case .headers -> $ update {
        case .'Content-Type' -> "text/csv"
      }
    }
  }
}
