let asm: String = """
.intel_syntax noprefix
.global main
main:
  mov rax, 123
  ret
"""

print(asm)
