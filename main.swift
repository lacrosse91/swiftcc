import Foundation


let first: String = """
.intel_syntax noprefix
.global main
"""
enum NextOperator {
    case plus
    case minus
    case unknown
    case first
}
func main() -> Int {

    let argv = ProcessInfo.processInfo.arguments

    let code: String = argv[1]


    var nextOperator: NextOperator = .first

    print(first)

    print("main:")
    let token = parse(code)

    for p in token {
        if p == "+" {
            nextOperator = .plus
            continue
        }
        if p == "-" {
            nextOperator = .minus
            continue
        }
        switch nextOperator {
        case .plus:
            print("\tadd rax, \(p)")
        case .minus:
            print("\tsub rax, \(p)")
        case .unknown:
            print("予期せぬ値です")
        case .first:
            print("\tmov rax, \(p)")
        }
    }

    print("\tret")


    return 0
}

func parse(_ code: String) -> [String] {


    var parsedCode: [String] = []
    let tagger = NSLinguisticTagger(tagSchemes: NSLinguisticTagger.availableTagSchemes(forLanguage: "en"), options: 0)

    tagger.string = code

    tagger.enumerateTags(in: NSRange(location: 0, length: code.count),
                         scheme: NSLinguisticTagScheme.lexicalClass,
                         options: [.omitWhitespace]) { tag, tokenRange, sentenceRange, stop in

                            let subString = (code as NSString).substring(with: tokenRange)
                            parsedCode.append(subString)

    }
    return parsedCode
}
//返り値を取らないとwarningが出ます
_ = main()
