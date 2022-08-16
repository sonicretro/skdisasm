CFLAGS := -O2 -s -std=c99 -Wall -Wextra -pedantic -fno-ident

s3p2bin: s3p2bin.c memory_stream.c accurate-kosinski/kosinski_compress.c clownlzss/common.c clownlzss/kosinski.c
	$(CC) $(CFLAGS) $(CPPFLAGS) $(LDFLAGS) -I. -o $@ $^ $(LIBS)
