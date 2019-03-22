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

    if argv.count != 2 {
    	print("引数の個数が正しくありません")
    	return 1
    }


    let code: String = argv[1]

    var nextOperator: NextOperator = .first

    print(first)

    print("main:")

    for p in code {
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

//返り値を取らないとwarningが出ます
_ = main()
