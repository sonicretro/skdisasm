cmake_minimum_required(VERSION 3.20)

project(s3p2bin LANGUAGES C)

add_executable(s3p2bin 
	"s3p2bin.c"
	"memory_stream.c"
	"accurate-kosinski/kosinski_compress.c"
	"clownlzss/common.c"
	"clownlzss/kosinski.c"
)

target_include_directories(s3p2bin PRIVATE ".")
