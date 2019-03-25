//
//  main.swift
//  swiftTutorialForBeginer
//
//  Created by 川内翔一朗 on 2018/12/21.
//  Copyright © 2018 川内翔一朗. All rights reserved.
//

import Foundation


let first: String = """
.intel_syntax noprefix
.global main
"""
enum Value {
    case TK_NUM
    case TK_EOF
    case PLUS
    case MINUS
}
struct Token {
    var ty: Value
    var val: Int = 0
    var input: String
}


enum NextOperator {
    case plus
    case minus
    case unknown
    case first
}
func main() -> Int {

    let argv = ProcessInfo.processInfo.arguments

    let code: String = argv[1]

    print(first)

    print("main:")
    let parsedCode = parse(code)

    let tokens = tokenize(parsedCode)


    var i: Int = 0

    while tokens[i].ty != .TK_EOF {
        if i == 0 {
            print("\tmov rax, \(tokens[i].val)")
            i += 1
            continue
        }

        if tokens[i].ty == .PLUS {
            i += 1
            print("\tadd rax, \(tokens[i].val)")
            i += 1
            continue
        }
        if tokens[i].ty == .MINUS {
            i += 1
            print("\tsub rax, \(tokens[i].val)")
            i += 1
            continue
        }
    }

    print("\tret")



    return 0
}

func tokenize(_ token: [String]) -> [Token] {
    var tokens: [Token] = []
    for t in token {
        if t == "+" {
            let plusToken = Token(ty: Value.PLUS, val: 0, input: t)
            tokens.append(plusToken)
            continue
        }
        if t == "-" {
            let minusToken = Token(ty: Value.MINUS, val: 0, input: t)
            tokens.append(minusToken)
            continue
        }
        if let tInt: Int = Int(t) {
            let intToken = Token(ty: Value.TK_NUM, val: tInt, input: t)
            tokens.append(intToken)
            continue
        }

    }
    let fin = Token(ty: Value.TK_EOF, val: 0, input: "EOF")
    tokens.append(fin)
    return tokens
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



