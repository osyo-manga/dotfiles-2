" 
" A fork of the official go syntax file.
"
" Options:
"
"   There are some options for customizing the highlighting; the recommended
"   settings are the default values, but you can write:
"     let OPTION_NAME = 0
"   in your ~/.vimrc file to disable particular options. You can also write:
"     let OPTION_NAME = 1
"   to enable particular options. At present, all options default to on.
"
"   - go_highlight_array_whitespace_error
"     Highlights white space after '[]'.
"   - go_highlight_chan_whitespace_error
"     Highlights white space around the communications operator that don't follow
"     the standard style.
"   - go_highlight_extra_types
"     Highlights commonly used library types (io.Reader, etc.).
"   - go_highlight_space_tab_error
"     Highlights instances of tabs following spaces.
"   - go_highlight_trailing_whitespace_error
"     Highlights trailing white space.


" Quit when a (custom) syntax file was already loaded
if exists("b:current_syntax")
  finish
endif

if !exists("go_highlight_array_whitespace_error")
  let go_highlight_array_whitespace_error = 1
endif
if !exists("go_highlight_chan_whitespace_error")
  let go_highlight_chan_whitespace_error = 0
endif
if !exists("go_highlight_extra_types")
  let go_highlight_extra_types = 1
endif
if !exists("go_highlight_space_tab_error")
  let go_highlight_space_tab_error = 1
endif
if !exists("go_highlight_trailing_whitespace_error")
  let go_highlight_trailing_whitespace_error = 0
endif

syn case match


" Keywords

syn keyword     goDirective         package import
syn keyword     goDeclaration       var const type
syn keyword     goStatement         goto return defer  
syn keyword     goGoroutine         go
syn keyword     goConditional       if else switch select fallthrough
syn keyword     goLabel             case default
syn keyword     goRepeat            for range break continue

syn match       goDeclType            /\<struct\s/ 
syn match       goDeclType          /\<interface\s/

hi def link     goStatement         Statement
hi def link     goDirective         Statement
hi def link     goConditional       Conditional
hi def link     goRepeat            Repeat
hi def link     goDeclaration       goStatement
hi def link     goLabel             goConditional
hi def link     goDeclType          goDeclaration


" Types

" avoiding 'syn keyword ..' is useful for not highlighting 
" type conversion built-in functions
syn keyword     goType               map chan
syn match       goType               "\<string\>\((\)\@!"
syn match       goType               "\<bool\>\((\)\@!"
syn match       goType               "\<error\>\((\)\@!"
syn match       goType               "\<byte\>\((\)\@!"
syn match       goType               "\<int\>\((\)\@!"
syn match       goSignedInts         "\<int8\>\((\)\@!"
syn match       goSignedInts         "\<int16\>\((\)\@!"
syn match       goSignedInts         "\<int32\>\((\)\@!"
syn match       goSignedInts         "\<int64\>\((\)\@!"
syn match       goSignedInts         "\<rune\>\((\)\@!"
syn match       goUnsignedInts       "\<uint\>\((\)\@!"
syn match       goUnsignedInts       "\<uint8\>\((\)\@!"
syn match       goUnsignedInts       "\<uint16\>\((\)\@!"
syn match       goUnsignedInts       "\<uint32\>\((\)\@!"
syn match       goUnsignedInts       "\<uint64\>\((\)\@!"
syn match       goFloats             "\<float32\>\((\)\@!"
syn match       goFloats             "\<float64\>\((\)\@!"
syn match       goComplexes          "\<complex32\>\((\)\@!"
syn match       goComplexes          "\<complex64\>\((\)\@!"

syn match       goType               "\[\]string\>"
syn match       goType               "\[\]bool\>"
syn match       goType               "\[\]error\>"
syn match       goType               "\[\]byte\>"
syn match       goType               "\[\]int\>"
syn match       goSignedInts         "\[\]int8\>"
syn match       goSignedInts         "\[\]int16\>"
syn match       goSignedInts         "\[\]int32\>"
syn match       goSignedInts         "\[\]int64\>"
syn match       goSignedInts         "\[\]rune\>" 
syn match       goUnsignedInts       "\[\]uint\>"
syn match       goUnsignedInts       "\[\]uint8\>"
syn match       goUnsignedInts       "\[\]uint16\>"
syn match       goUnsignedInts       "\[\]uint32\>"
syn match       goUnsignedInts       "\[\]uint64\>"
syn match       goFloats             "\[\]float32\>"
syn match       goFloats             "\[\]float64\>" 
syn match       goComplexes          "\[\]complex32\>"
syn match       goComplexes          "\[\]complex64\>"

" Treat func specially: it's a declaration at the start of a line, but a type
" elsewhere. Order matters here.
syn match       goType              /\<func\>/
syn match       goFuncDecl          /^func\>/

syn match       goSpecial           /\v\<-/
syn match       goType              /\vchan\<-/
syn match       goType              /\v\<-chan/
syn match       goType              /interface{}/
syn match       goType              /\(^func\s(\w\+\s\)\@<=\*\=\w\+/

hi def link     goType              Type
hi def link     goSignedInts        Type
hi def link     goUnsignedInts      Type
hi def link     goFloats            Type
hi def link     goComplexes         Type
hi def link     goFuncDecl          goDeclaration


" Functions

syn match       goFunction          /\(^func\s\(([^()]\{-})\s\)\=\)\@<=\w\+/

hi def link     goFunction          Function


" Predefined functions and values

syn keyword     goBuiltins          append cap close complex copy delete imag len
syn keyword     goBuiltins          make new  print println real recover
syn keyword     goConstants         iota true false nil
"syn keyword     goPanic             panic 

"hi def link     goPanic             Exception
hi def link     goBuiltins          Keyword
hi def link     goConstants         Constant


" Comments

syn keyword     goTodo              contained TODO FIXME XXX BUG
syn cluster     goCommentGroup      contains=goTodo
syn region      goComment           start="/\*" end="\*/" contains=@goCommentGroup,@Spell
syn region      goComment           start="//" end="$" contains=@goCommentGroup,@Spell

hi def link     goComment           Comment
hi def link     goTodo              Todo


" Go escapes

syn match       goEscapeOctal       display contained "\\[0-7]\{3}"
syn match       goEscapeC           display contained +\\[abfnrtv\\'"]+
syn match       goEscapeX           display contained "\\x\x\{2}"
syn match       goEscapeU           display contained "\\u\x\{4}"
syn match       goEscapeBigU        display contained "\\U\x\{8}"
syn match       goEscapeError       display contained +\\[^0-7xuUabfnrtv\\'"]+

hi def link     goEscapeOctal       goSpecialString
hi def link     goEscapeC           goSpecialString
hi def link     goEscapeX           goSpecialString
hi def link     goEscapeU           goSpecialString
hi def link     goEscapeBigU        goSpecialString
hi def link     goSpecialString     String
hi def link     goEscapeError       Error


" Strings

syn cluster     goStringGroup       contains=goEscapeOctal,goEscapeC,goEscapeX,goEscapeU,goEscapeBigU,goEscapeError
syn region      goString            start=+"+ skip=+\\\\\|\\"+ end=+"+ contains=@goStringGroup
syn region      goRawString         start=+`+ end=+`+

hi def link     goString            String
hi def link     goRawString         String


" Characters

syn cluster     goCharacterGroup    contains=goEscapeOctal,goEscapeC,goEscapeX,goEscapeU,goEscapeBigU
syn region      goCharacter         start=+'+ skip=+\\\\\|\\'+ end=+'+ contains=@goCharacterGroup

hi def link     goCharacter         Character


" Regions

syn region      goBlock             start="{" end="}" transparent fold
syn region      goParen             start='(' end=')' transparent


" Numbers

syn match       goDecimalInt        "\<\d\+\([Ee]\d\+\)\?\>"
syn match       goHexadecimalInt    "\<0x\x\+\>"
syn match       goOctalInt          "\<0\o\+\>"
syn match       goOctalError        "\<0\o*[89]\d*\>"
syn match       goFloat             "\<\d\+\.\d*\([Ee][-+]\d\+\)\?\>"
syn match       goFloat             "\<\.\d\+\([Ee][-+]\d\+\)\?\>"
syn match       goFloat             "\<\d\+[Ee][-+]\d\+\>"
syn match       goImaginary         "\<\d\+i\>"
syn match       goImaginary         "\<\d\+\.\d*\([Ee][-+]\d\+\)\?i\>"
syn match       goImaginary         "\<\.\d\+\([Ee][-+]\d\+\)\?i\>"
syn match       goImaginary         "\<\d\+[Ee][-+]\d\+i\>"

hi def link     goDecimalInt        goNumber
hi def link     goHexadecimalInt    goNumber
hi def link     goOctalInt          goNumber
hi def link     goFloat             goNumber
hi def link     goImaginary         goNumber
hi def link     goNumber            Number 


" Extras

" Spaces after "[]"
if go_highlight_array_whitespace_error != 0
  syn match goSpaceError display "\(\[\]\)\@<=\s\+"
endif

" Spacing errors around the 'chan' keyword
if go_highlight_chan_whitespace_error != 0
  " receive-only annotation on chan type
  syn match goSpaceError display "\(<-\)\@<=\s\+\(chan\>\)\@="
  " send-only annotation on chan type
  syn match goSpaceError display "\(\<chan\)\@<=\s\+\(<-\)\@="
  " value-ignoring receives in a few contexts
  syn match goSpaceError display "\(\(^\|[={(,;]\)\s*<-\)\@<=\s\+"
endif

" Extra types commonly seen
if go_highlight_extra_types != 0
  syn match goExtraType /\*\=\<tar\.\(Header\|Reader\|Writer\)\>/
  syn match goExtraType /\*\=\<zip\.\(File\|FileHeader\|ReadCloser\|Reader\|Writer\)\>/
  syn match goExtraType /\*\=\<bufio\.\(ReadWriter\|Reader\|Scanner\|SplitFunc\|Writer\)\>/
  syn match goExtraType /\*\=\<builtin\.\(ComplexType\|FloatType\|IntegerType\|Type\|Type1\|bool\|byte\|complex128\|complex64\|error\|float32\|float64\|int\|int16\|int32\|int64\|int8\|rune\|string\|uint\|uint16\|uint32\|uint64\|uint8\|uintptr\)\>/
  syn match goExtraType /\*\=\<bytes\.\(Buffer\|Reader\)\>/
  syn match goExtraType /\*\=\<bzip2\.StructuralError\>/
  syn match goExtraType /\*\=\<flate\.\(CorruptInputError\|InternalError\|ReadError\|Reader\|WriteError\|Writer\)\>/
  syn match goExtraType /\*\=\<gzip\.\(Header\|Reader\|Writer\)\>/
  syn match goExtraType /\*\=\<lzw\.Order\>/
  syn match goExtraType /\*\=\<zlib\.Writer\>/
  syn match goExtraType /\*\=\<heap\.Interface\>/
  syn match goExtraType /\*\=\<list\.\(Element\|List\)\>/
  syn match goExtraType /\*\=\<ring\.Ring\>/
  syn match goExtraType /\*\=\<crypto\.\(Hash\|PrivateKey\)\>/
  syn match goExtraType /\*\=\<aes\.KeySizeError\>/
  syn match goExtraType /\*\=\<cipher\.\(Block\|BlockMode\|Stream\|StreamReader\|StreamWriter\)\>/
  syn match goExtraType /\*\=\<des\.KeySizeError\>/
  syn match goExtraType /\*\=\<dsa\.\(ParameterSizes\|Parameters\|PrivateKey\|PublicKey\)\>/
  syn match goExtraType /\*\=\<ecdsa\.\(PrivateKey\|PublicKey\)\>/
  syn match goExtraType /\*\=\<elliptic\.\(Curve\|CurveParams\)\>/
  syn match goExtraType /\*\=\<rc4\.\(Cipher\|KeySizeError\)\>/
  syn match goExtraType /\*\=\<rsa\.\(CRTValue\|PrecomputedValues\|PrivateKey\|PublicKey\)\>/
  syn match goExtraType /\*\=\<tls\.\(Certificate\|ClientAuthType\|Config\|Conn\|ConnectionState\)\>/
  syn match goExtraType /\*\=\<pkix\.\(AlgorithmIdentifier\|AttributeTypeAndValue\|CertificateList\|Extension\|name\|RDNSequence\|RelativeDistinguishedNameSET\|RevokedCertificate\|TBSCertificateList\)\>/
  syn match goExtraType /\*\=\<sql\.\(DB\|NullBool\|NullFloat64\|NullInt64\|NullString\|RawBytes\|Result\|Row\|Rows\|Scanner\|Stmt\|Tx\)\>/
  syn match goExtraType /\*\=\<driver\.\(ColumnConverter\|Conn\|Driver\|Execer\|NotNull\|Null\|Queryer\|Result\|Rows\|RowsAffected\|Stmt\|Tx\|Value\|ValueConverter\|Valuer\)\>/

  " copy this
  "syn match goExtraType /\*\=\<bytes\.\(Buffer\|Reader\)\>\((\)\@!/

  """
  syn match goExtraType /\*\=\<io\.\(Reader\|Writer\|ReadWriter\|ReadWriteCloser\|LimitedReader\|PipeReader\|PipeWriter\|ReadCloser\|ReadSeeker\|ReadWriteSeeker\|ReaderAt\|ReaderFrom\|RuneReader\|RuneScanner\|SectionReader\|Seeker\|WriteCloser\|WriteSeeker\|WriterAt\|WriterTo\)\>\((\)\@!/
  syn match goExtraType /\*\=\<reflect\.\(Kind\|Type\|Value\|ChanDir\|Method\|SelectCase\|SelectDir\|SliceHeader\|StringHeader\|StructField\|StructTag\|ValueError\)\>\((\)\@!/
  syn match goExtraType /\*\=\<unsafe\.\(Pointer\|ArbitraryType\)\>\((\)\@!/
  syn match goExtraType /\*\=\<json\.\(Decoder\|Encoder\|InvalidUTF8Error\|InvalidUnmarshalError\|Marshaler\|MarshalerError\|Number\|RawMessage\|SyntaxError\|UnmarshalFieldError\|UnmarshalTypeError\|Unmarshaler\|UnsupportedTypeError\|UnsupportedValueError\)\>\((\)\@!/
  syn match goExtraType /\*\=\<fmt\.\(Formatter\|GoStringer\|ScanState\|Scanner\|State\|Stringer\)\>\((\)\@!/
  syn match goExtraType /\*\=\<flag\.\(ErrorHandling\|Flag\|FlagSet\|Value\)\>/
  syn match goExtraType /\*\=\<template\.\(CSS\|Error\|ErrorCode\|FuncMap\|HTML\|HTMLAttr\|JS\|JSStr\|Template\|URL\)\>\((\)\@!/
  syn match goExtraType /\*\=\<net\.\(Addr\|AddrError\|Conn\|DNSConfigError\|DNSError\|Dialer\|Error\|Flags\|HardwareAddr\|IP\|IPAddr\|IPConn\|IPMask\|IPNet\|Interface\|InvalidAddrError\|Listener\|MX\|NS\|OpError\|PacketConn\|ParseError\|SRV\|TCPAddr\|TCPConn\|TCPListener\|UDPAddr\|UDPConn\|UnixAddr\|UnixConn\|UnixListener\|UnknownNetworkError\)\>\((\)\@!/
  syn match goExtraType /\*\=\<http\.\(Client\|CloseNotifier\|Cookie\|CookieJar\|Dir\|File\|FileSystem\|Flusher\|Handler\|HandlerFunc\|Header\|Hijacker\|ProtocolError\|Request\|ResponseWriter\|RoundTripper\|ServeMux\|Server\|Transport\)\>\((\)\@!/
  syn match goExtraType /\*\=\<testing\.\(B\|BenchmarkResult\|InternalBenchmark\|InternalExample\|InternalTest\|T\)\>\((\)\@!/
  syn match goExtraType /\*\=\<time\.\(Duration\|Location\|Month\|ParseError\|Ticker\|Time\|Timer\|Weekday\)\>\((\)\@!/
endif

" Space-tab error
if go_highlight_space_tab_error != 0
  syn match goSpaceError display " \+\t"me=e-1
endif

" Trailing white space error
if go_highlight_trailing_whitespace_error != 0
  syn match goSpaceError display excludenl "\s\+$"
endif

hi def link     goExtraType         Type
hi def link     goSpaceError        Error

syn sync minlines=500

let b:current_syntax = "go"
