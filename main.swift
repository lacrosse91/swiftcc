
import Foundation

let first: String = """
.intel_syntax noprefix
.global main
"""

func main() -> Int {
	let argv = ProcessInfo.processInfo.arguments
	if argv.count != 2 {
		print("引数の個数を確認してください")
		return 1
	}
    print(first)

    print("main:")
    print("\tmov rax, \(argv[1])")
    print("\tret")



    return 0
}

//返り値を取らないとwarningが出ます
_ = main()