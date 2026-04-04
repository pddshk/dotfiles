using Crayons
import OhMyREPL: Passes.SyntaxHighlighter

function _create_catppuccin_mocha_colorscheme()
    scheme = SyntaxHighlighter.ColorScheme()
    SyntaxHighlighter.symbol!(scheme, crayon"f38ba8")
    SyntaxHighlighter.comment!(scheme, crayon"9399b2")
    SyntaxHighlighter.string!(scheme, crayon"a6e3a1")
    SyntaxHighlighter.call!(scheme, crayon"89b4fa")
    SyntaxHighlighter.op!(scheme, crayon"89dceb")
    SyntaxHighlighter.keyword!(scheme, crayon"cba6f7")
    SyntaxHighlighter.macro!(scheme, crayon"89b4fa")
    SyntaxHighlighter.function_def!(scheme, crayon"89b4fa")
    SyntaxHighlighter.text!(scheme, crayon"cdd6f4")
    SyntaxHighlighter.error!(scheme, crayon"f38ba8")
    SyntaxHighlighter.argdef!(scheme, crayon"f9e2af")
    SyntaxHighlighter.number!(scheme, crayon"fab387")
    scheme
end

SyntaxHighlighter.add!("CatppuccinMocha", _create_catppuccin_mocha_colorscheme())
