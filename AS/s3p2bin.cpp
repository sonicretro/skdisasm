#include <string.h>
#include <stdio.h>
#include <unistd.h> // for unlink

const char* codeFileName = NULL;
const char* romFileName = NULL;
const char* shareFileName = NULL;
int compressedLength = 0;

void printUsage() { printf("usage: s3p2bin.exe inputcodefile.p outputromfile.bin sharefile.h\n"); }
bool buildRom(FILE* from, FILE* to);
void editShareFile();

int main(int argc, char *argv[])
{
//	for(int i = 0 ; i < argc ; i++)
//		printf("arg %d is %s\n", i, argv[i]);

	if(argc > 2)
		argc--, argv++; // skip the exe filename

	if(argc < 2)
		printUsage();

	while(argc)
	{
		char* arg = argv[0];
		argc--, argv++; // pop arg
		
		if(!strcasecmp(arg, "-h") || !strcasecmp(arg, "--help"))
			printUsage(), argc = 0;
		else if(!codeFileName)
			codeFileName = arg;
		else if(!romFileName)
			romFileName = arg;
		else if(!shareFileName)
			shareFileName = arg;
	}

	if(codeFileName && romFileName)
	{
		printf("\ns3p2bin.exe: generating %s from %s", romFileName, codeFileName);
		
		FILE* from = fopen(codeFileName, "rb");
		if(from)
		{
			FILE* to = fopen(romFileName, "wb");
			if(to)
			{
				bool built = buildRom(from, to);
				fclose(to);
				fclose(from);
				if(built)
				{
					editShareFile();
					printf(" ... done.");
				}
				else
				{
					unlink(romFileName); // error; delete the rom because it's probably hosed
				}
			}
			else
				printf("\nERROR: Failed to access file \"%s\".", romFileName);
		}
		else
			printf("\nERROR: Failed to load file \"%s\".", codeFileName);
	}
	
	printf("\n");
//	system("PAUSE");
	return 0;
}

void editShareFile()
{
	if(shareFileName && compressedLength > 0)
	{
		FILE* share = fopen(shareFileName, "rb+");
		if(share)
		{
			fseek(share, 0, SEEK_SET);
			fprintf(share, "comp_z80_size 0x%X ", compressedLength);
			fclose(share);
		}
	}
}

long KComp3(FILE *Src, FILE *Dst, int SlideWin, int RecLen, int srcStart, int srcLen, bool Moduled);

bool buildRom(FILE* from, FILE* to)
{
	if(fgetc(from) != 0x89) printf("\nWarning: First byte of a .p file should be $89");
	if(fgetc(from) != 0x14) printf("\nWarning: Second byte of a .p file should be $14");
	
	int cpuType = 0, segmentType = 0, granularity = 0, lastType = 0;
	signed long start = 0, lastStart = 0, z80Start = 0;
	unsigned short length = 0, lastLength = 0, z80Length = 0;
	static const int scratchSize = 4096;
	unsigned char scratch [scratchSize];
	bool lastSegmentCompressed = false;

	int check_size = 0;
	bool done=false;

	while(!done)
	{
		int tempbuf;
		int temp_length;
		unsigned char headerByte = fgetc(from);

		if(ferror(from) || feof(from))
			break;

		switch(headerByte)
		{
			case 0x00: // "END" segment
				done=true; break;
			case 0x80: // "entry point" segment
				fseek(from, 3, SEEK_CUR);
				continue;
			case 0x81:  // code or data segment
				tempbuf = fgetc(from);
				tempbuf = fgetc(from);
				tempbuf = fgetc(from);
				break;
			default:
				if(headerByte > 0x81)
					{ printf("\nERROR: Unsupported segment header $%02X", headerByte); return false; }
				tempbuf = headerByte;
				break;
		}

		if(!done)
		{
			tempbuf=0;
			tempbuf = fgetc(from); // integers in AS .p files are always little endian
			tempbuf |= fgetc(from) << 8;
			tempbuf |= fgetc(from) << 16;
			tempbuf |= fgetc(from) << 24;
			temp_length = fgetc(from);
			temp_length |= fgetc(from) << 8;

			if(tempbuf+temp_length > check_size) check_size = tempbuf+temp_length;

			fseek(from,temp_length,SEEK_CUR);
		}
	}

	for(int i=0; i<check_size; i++)
		fputc(0xFF,to);

	fseek(to,0,SEEK_SET);
	fseek(from,2,SEEK_SET);
	
	while(true)
	{
		unsigned char headerByte = fgetc(from);
		if(ferror(from) || feof(from))
			break;

		switch(headerByte)
		{
			case 0x00: // "END" segment
				return true;
			case 0x80: // "entry point" segment
				fseek(from, 3, SEEK_CUR);
				continue;
			case 0x81:  // code or data segment
				cpuType = fgetc(from);
				segmentType = fgetc(from);
				granularity = fgetc(from);
				if(granularity != 1)
					{ printf("\nERROR: Unsupported granularity %d.", granularity); return false; }
				break;
			default:
				if(headerByte > 0x81)
					{ printf("\nERROR: Unsupported segment header $%02X", headerByte); return false; }
				cpuType = headerByte;
				break;
		}

		start = fgetc(from); // integers in AS .p files are always little endian
		start |= fgetc(from) << 8;
		start |= fgetc(from) << 16;
		start |= fgetc(from) << 24;
		length = fgetc(from);
		length |= fgetc(from) << 8;

		if(length == 0)
		{
			// error instead of warning because I had quite a bad freeze the one time I saw this warning go off
			printf("\nERROR: zero length segment ($%X).", length);
			return false;
		}

		if(start < 0)
		{
			printf("\nERROR: negative start address ($%X).", start), start = 0;
			return false;
		}

		if(cpuType == 0x51 && (start != 0 && start != 0x1300) && lastSegmentCompressed)
		{
			printf("\nERROR: The compressed Z80 code (Z80 Sound Driver.asm) must have exactly two segments, one starting at $0 and one starting at $1300. That means no ORG/ALIGN/CNOP/EVEN or memory reservation commands in the Z80 code besides those two points and the size must be < 65535 bytes. The offending new segment starts at address $%X relative to the start of the Z80 code.", start);
			return false;
		}

		if(cpuType == 0x51 && start == 0) // 0x51 is the type for Z80 family (0x01 is for 68000)
		{
			// Saxman compressed Z80 segment
			start = lastStart + lastLength;
			z80Start = start;
			int srcStart = ftell(from);
			compressedLength += KComp3(from, to, 8192, 256, srcStart, length, false);
			fseek(from, srcStart + length, SEEK_SET);
			lastStart = start;
			lastLength = length;
			lastType = cpuType;
			continue;
		}

		if(cpuType == 0x51 && start == 0x1300) // 0x51 is the type for Z80 family (0x01 is for 68000)
		{
			// Saxman compressed Z80 segment
			start = lastStart + lastLength;
			int srcStart = ftell(from);
			int temp;
			temp = KComp3(from, to, 8192, 256, srcStart, length, false);
			compressedLength += temp;
			fseek(from, srcStart + length, SEEK_SET);
			lastSegmentCompressed = true;
			start = z80Start + compressedLength;
			continue;
		}
		else if(lastType == 0x51 && lastStart == 0)
		{
			printf("\nERROR: Second segment of sound driver at $1300 MUST follow directly after the first.");
			return false;
		}

		if(!lastSegmentCompressed)
		{
			if(start+3 < ftell(to)) // 3 bytes of leeway for instruction patching
				printf("\nWarning: overlapping allocation detected! $%X < $%X", start, ftell(to));
		}
		else
		{
			if(start < ftell(to))
			{
				printf("\nERROR: Compressed sound driver might not fit.\nPlease increase your value of Size_of_Snd_driver_guess to at least $%X and try again.", compressedLength);
				return false;
			}
		}

		lastStart = start;
		lastLength = length;
		lastType = cpuType;
		lastSegmentCompressed = false;


		fseek(to, start, SEEK_SET);

//		printf("copying $%X-$%X -> $%X-$%X\n", ftell(from), ftell(from)+length, start, start+length);
		while(length)
		{
			int copy = length;
			if(copy > scratchSize)
				copy = scratchSize;
			fread(scratch, copy, 1, from);
			fwrite(scratch, copy, 1, to);
			length -= copy;
		}
		
	}

	return true;
}
